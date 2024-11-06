from __future__ import annotations

import asyncio
import datetime
import json
import logging
import traceback
from typing import TYPE_CHECKING, Any

import aiofiles
from agent_eval.grader import grader_chain
from agent_eval.grader.prompt import (
    DEFAULT_CRITERIA_WITH_REFERENCE_ANSWER,
    DEFAULT_CRITERIA_WITHOUT_REFERENCE_ANSWER,
)
from agent_eval.student import create_student_graph, student_context
from agent_eval.workflow import create_eval_workflow
from langchain_openai import ChatOpenAI
from langgraph.checkpoint.memory import MemorySaver
from tqdm.asyncio import tqdm

if TYPE_CHECKING:
    from agent_eval.config import EvalSettings
    from langgraph.checkpoint.base import Checkpoint


logger = logging.getLogger(__name__)

# TODO: make this configurable, and we can continue running after an error
eval_run_output_file = f"eval_run_{datetime.datetime.now(tz=datetime.UTC).strftime('%Y%m%d_%H%M%S')}.jsonl"


class Evaluator:
    """TableGPT Evaluator.

    config(config.EvalSettings): evaluator configuration.
    client(langfuse.Langfuse): Langfuse client.
    grader(langchain_core.runnables.Runnable): Grader used to grade the student's answer.
    """

    def __init__(self, config: EvalSettings) -> None:
        """Initialize the Evaluator with the given configuration.

        Args:
            config (dict): Configuration dictionary for the Evaluator.
        """

        logger.info("Initializing evaluator with config: %s}", config)
        self.config = config
        self.grader = grader_chain(ChatOpenAI(**config.grader))
        logger.info("Evaluator initialized")

    async def run_eval(
        self,
        payload: dict[str, Any],
        student_context: dict[str, Any] | None = None,
    ) -> None:
        """Run the evaluation workflow.
        Usually a student runnable will be executed, followed by a grader runnable.

        Args:
            payload (dict[str, Any]): Evaluation payload.
            student_context (dict[str, Any] | None, optional): Context to be passed to the student. Defaults to None.
        """

        if student_context is None:
            student_context = {}

        with MemorySaver() as checkpointer:
            student = await create_student_graph(
                datasets=payload.get("datasets"),
                checkpointer=checkpointer,
                **student_context,
            )

            eval_wf = create_eval_workflow(student=student, grader=self.grader)

            item: dict[str, Any] = payload["item"]
            criteria = payload.get("criteria")
            if not criteria:
                criteria = (
                    DEFAULT_CRITERIA_WITH_REFERENCE_ANSWER
                    if item["expected_output"]
                    else DEFAULT_CRITERIA_WITHOUT_REFERENCE_ANSWER
                )
            try:
                res = await eval_wf.ainvoke(
                    input={
                        "input": item["input"],
                        "reference_answer": item["expected_output"],
                        "criteria": criteria,
                        "redlines": payload.get("redlines", []),
                    },
                )
                grader_result = res["grader_result"]
            except Exception:
                logger.exception(
                    "Student Workflow failed, item: %s, context: %s",
                    item["input"],
                    student_context,
                )
                # We treat any exception in agent invocation as a bad case
                err_info = traceback.format_exc()
                grader_result = {
                    "score": 0,
                    "explaination": err_info,
                }

            checkpoint: Checkpoint = checkpointer.get(
                config={
                    "configurable": {"thread_id": student_context["session_id"]},
                }
            )
            messages = checkpoint["channel_values"].get("messages", [])
            messages = [message.dict() for message in messages]

            eval_result = {
                "input": item["input"],
                "score": grader_result,
                "reference_answer": item["expected_output"],
                "student_answer": res["student_answer"],
                "criteria": criteria,
                "redlines": payload.get("redlines", []),
                "messages": messages,
            }

            async with aiofiles.open(eval_run_output_file, mode="a") as f:
                await f.write(json.dumps(eval_result, ensure_ascii=False) + "\n")

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
        async with student_context() as context:
            while True:
                if stop_event.is_set():
                    logger.warning("Worker received stop event, cancelling...")
                    break
                try:
                    payload = queue.get_nowait()
                    await self.run_eval(payload=payload, student_context=context)
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

    async def run(self, stop_event: asyncio.Event) -> None:
        """Gather evaluation samples and run the evaluation process, in parallel."""
        logger.info("Gathering evaluation samples...")
        queue = asyncio.Queue()
        for dataset_config in self.config.datasets:
            logger.debug("Gathering samples from dataset: %s...", dataset_config.name)

            # TODO: open with aiofiles
            with open(dataset_config.name) as f:  # noqa: ASYNC101
                dataset = json.load(f)
            _samples = gather_samples(dataset)
            logger.debug(
                "Gathered %d samples from dataset %s",
                len(_samples),
                dataset_config.name,
            )
            for sample in _samples:
                for _ in range(self.config.num_repetitions):
                    await queue.put(sample)
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
                await asyncio.gather(*eval_tasks, return_exceptions=True)  # Ensure all consumers exit
            except Exception:
                logger.exception("Error in evaluator")
            finally:
                logger.info("Shutting down evaluator...")


def gather_samples(dataset: list[dict[str, Any]]) -> list[dict[str, Any]]:
    active_samples = [item for item in dataset if item["status"] != "ARCHIVED"]

    return [
        {
            "item": item,
            "datasets": item.get("attachments", []),
        }
        for item in active_samples
    ]
