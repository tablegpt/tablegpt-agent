from __future__ import annotations

import asyncio
import datetime
import json
import logging
import traceback
from typing import TYPE_CHECKING, Any

import aiofiles
from langchain_openai import ChatOpenAI
from langgraph.checkpoint.memory import MemorySaver
from tqdm.asyncio import tqdm

from .evaluatee import create_evaluatee_runnable, evaluatee_context
from .evaluator import create_evaluator_runnable
from .evaluator.prompt import (
    DEFAULT_CRITERIA_WITH_REFERENCE_ANSWER,
    DEFAULT_CRITERIA_WITHOUT_REFERENCE_ANSWER,
)
from .workflow import create_eval_workflow

if TYPE_CHECKING:
    from agent_eval.config import EvalSettings
    from langgraph.checkpoint.base import Checkpoint


logger = logging.getLogger(__name__)

# TODO: make this configurable, and we can continue running after an error
eval_run_output_file = f"eval_run_{datetime.datetime.now(tz=datetime.UTC).strftime('%Y%m%d_%H%M%S')}.jsonl"


class Runner:
    """Evaluation task runner.

    config(config.EvalSettings): evaluation configuration.
    client(langfuse.Langfuse): Langfuse client.
    evaluator(langchain_core.runnables.Runnable): Evaluator used to evaluate the evaluatee's answer.
    """

    def __init__(self, config: EvalSettings) -> None:
        """Initialize the Evaluator with the given configuration.

        Args:
            config (dict): Configuration dictionary for the Evaluator.
        """

        logger.info("Initializing evaluator with config: %s}", config)
        self.config = config
        self.evaluator = create_evaluator_runnable(ChatOpenAI(**config.evaluator))
        logger.info("Evaluator initialized")

    async def run(self, stop_event: asyncio.Event) -> None:
        """Gather evaluation samples and run the evaluation process, in parallel."""
        logger.info("Gathering evaluation samples...")
        queue = asyncio.Queue()
        await enqueue_samples(queue, self.config.datasets, self.config.num_repetitions)
        total_samples = queue.qsize()
        logger.info("Gathered %s samples for evaluation", total_samples)

        with tqdm(total=total_samples, desc="Evaluation samples") as pbar:
            try:
                eval_tasks = [
                    asyncio.create_task(
                        self.worker(queue, stop_event, pbar),
                        name=f"worker-{i}",
                    )
                    for i in range(self.config.max_concurrency)
                ]
                # Ensure all consumers exit
                await asyncio.gather(*eval_tasks, return_exceptions=True)
            except Exception:
                logger.exception("Error in evaluator")
            finally:
                logger.info("Shutting down evaluator...")

    async def worker(
        self,
        queue: asyncio.Queue,
        stop_event: asyncio.Event,
        pbar: tqdm | None = None,
    ) -> None:
        """Worker to process tasks from the task queue.

        Args:
            queue (asyncio.Queue): Task queue.
            stop_event (asyncio.Event): Stop events to signal the worker to stop.
            pbar (tqdm | None, optional): Progress bar to update task progress. Defaults to None.
        """
        logger.info("Worker started")
        async with evaluatee_context() as context:
            while not stop_event.is_set():
                try:
                    payload = queue.get_nowait()
                    await self.run_eval(payload=payload, evaluatee_context=context)
                    if pbar is not None:
                        pbar.update(1)
                except asyncio.QueueEmpty:
                    # No more tasks in the queue, quit current worker
                    logger.info("Worker finished")
                    break
                except Exception:
                    logger.exception("Worker encountered an error")
                    stop_event.set()  # Set the stop event to cancel other workers
                    break

    async def run_eval(
        self,
        payload: dict[str, Any],
        evaluatee_context: dict[str, Any] | None = None,
    ) -> None:
        """Run the evaluation workflow.
        Usually a evaluatee runnable will be executed, followed by a evaluator runnable.

        Args:
            payload (dict[str, Any]): Evaluation payload.
            evaluatee_context (dict[str, Any] | None, optional): Context to be passed to the evaluatee. Defaults to None.
        """

        if evaluatee_context is None:
            evaluatee_context = {}

        checkpointer = MemorySaver()
        evaluatee = await create_evaluatee_runnable(
            datasets=payload.get("datasets"),
            checkpointer=checkpointer,
            **evaluatee_context,
        )

        eval_wf = create_eval_workflow(evaluatee=evaluatee, evaluator=self.evaluator)

        item: dict[str, Any] = payload["item"]
        criteria = payload.get("criteria")
        try:
            res = await eval_wf.ainvoke(
                input={
                    "input": item["input"],
                    "reference_answer": item["expected_output"],
                    "criteria": criteria,
                    "redlines": payload.get("redlines", []),
                },
            )
            evaluation = res["evaluation"]
            evaluatee_answer = res["evaluatee_answer"]
        except Exception:
            logger.exception(
                "Evaluation Workflow failed, item: %s, context: %s",
                item["input"],
                evaluatee_context,
            )
            # We treat any exception in agent invocation as a bad case
            err_info = traceback.format_exc()
            evaluation = {
                "score": 0,
                "explaination": err_info,
            }
            evaluatee_answer = ""

        # TODO: get rid of the 'session_id'. It's a evaluatee thing.
        checkpoint: Checkpoint = checkpointer.get(
            config={
                "configurable": {"thread_id": evaluatee_context["session_id"]},
            }
        )
        messages = checkpoint["channel_values"].get("messages", [])
        messages = [message.dict() for message in messages]

        eval_result = {
            "input": item["input"],
            "evaluation": evaluation,
            "reference_answer": item["expected_output"],
            "evaluatee_answer": evaluatee_answer,
            "criteria": criteria,
            "redlines": payload.get("redlines", []),
            "messages": messages,
        }

        async with aiofiles.open(eval_run_output_file, mode="a") as f:
            await f.write(json.dumps(eval_result, ensure_ascii=False) + "\n")


async def enqueue_samples(queue: asyncio.Queue, dataset_configs: list[dict], num_repetitions: int = 1) -> None:
    """Reads datasets from the provided configurations, constructs samples, and enqueues them for processing.

    Args:
        queue (asyncio.Queue): The queue to which the samples will be added.
        dataset_configs (list[dict]): A list of dataset configurations, each containing a 'name' key pointing to the dataset file.
        num_repetitions (int, optional): The number of times each sample should be repeated in the queue. Defaults to 1.
    """
    for dataset_config in dataset_configs:
        logger.debug("Gathering samples from dataset: %s...", dataset_config.name)

        async with aiofiles.open(dataset_config.name) as f:
            content = await f.read()
            dataset = json.loads(content)
        _samples = construct_samples(dataset)
        logger.debug(
            "Gathered %d samples from dataset %s",
            len(_samples),
            dataset_config.name,
        )
        for sample in _samples:
            # Repeat each sample for `num_repetitions` times.
            for _ in range(num_repetitions):
                await queue.put(sample)


def construct_samples(dataset: list[dict[str, Any]]) -> list[dict[str, Any]]:
    """Constructs a list of samples from the dataset, filtering out archived items and adding metadata.

    Args:
        dataset (list[dict[str, Any]]): The dataset containing items with 'status', 'attachments', and 'expected_output' keys.

    Returns:
        list[dict[str, Any]]: A list of samples, each containing the item, its attachments, and evaluation criteria.
    """
    # Filter out archived samples
    active_samples = [sample for sample in dataset if sample["status"] != "ARCHIVED"]

    # Construct samples with additional metadata
    return [
        {
            "item": sample,
            "datasets": sample.get("attachments", []),
            "criteria": DEFAULT_CRITERIA_WITH_REFERENCE_ANSWER
            if sample["expected_output"]
            else DEFAULT_CRITERIA_WITHOUT_REFERENCE_ANSWER,
        }
        for sample in active_samples
    ]
