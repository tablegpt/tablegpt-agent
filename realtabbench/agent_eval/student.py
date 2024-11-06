from __future__ import annotations

import logging
import shutil
from contextlib import asynccontextmanager
from pathlib import Path
from typing import TYPE_CHECKING
from uuid import uuid4

from agent_eval.student_config import Settings
from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from pybox import LocalPyBoxManager
from pybox.kube import KubePyBoxManager
from pydantic import BaseModel
from tablegpt.agent import create_tablegpt_graph
from tablegpt.agent.file_reading import Stage

if TYPE_CHECKING:
    from langchain_core.runnables import Runnable
    from langgraph.checkpoint.base import BaseCheckpointSaver
    from langgraph.graph.graph import CompiledGraph


logger = logging.getLogger(__name__)


settings = Settings(_env_file=[".env"], _env_file_encoding="utf-8")

if settings.ipython_kernel.incluster:
    import os

    # Clear default mask. Allow the kernel to read and write shared volumes.
    os.umask(000)
    pybox_manager = KubePyBoxManager(
        incluster=settings.ipython_kernel.incluster,
        env_file=settings.ipython_kernel.env_file,
    )
else:
    pybox_manager = LocalPyBoxManager()

llm_args = settings.llm
model_type = llm_args.get("metadata", {}).get("model_type")
llm = ChatOpenAI(**llm_args)

vlm = ChatOpenAI(**settings.vlm) if settings.vlm else None
normalize_llm = ChatOpenAI(**settings.normalize_llm) if settings.normalize_llm is not None else None


# TODO: a copy-paste from tablegpt-chat
# We need to refactor this and push it down to tablegpt-agent
class Attachment(BaseModel):
    filename: str
    mimetype: str
    size: int = 0


@asynccontextmanager
async def student_context():
    """Make a context for TableGPT students.

    Yields:
        dict[str, Any]: kwargs to be passed to the workflow.
    """
    # A unique session id for this context. All student workflow under this context will share one Ipython kernel.
    session_id = f"eval-session-{uuid4().hex}"

    workdir = Path(settings.data_vol, session_id)
    logger.debug("Creating workdir: %s", workdir)
    workdir.mkdir(parents=True, exist_ok=True)

    # Spawn a kernel ahead
    await pybox_manager.astart(kernel_id=session_id, cwd=workdir)

    try:
        yield {
            "workdir": workdir,
            "session_id": session_id,
        }
    finally:
        logger.debug("Cleaning up worker resources...")
        logger.debug("Shutting down kernel: %s", session_id)
        await pybox_manager.ashutdown(session_id)
        logger.debug("Removing workdir: %s", workdir)
        shutil.rmtree(workdir, ignore_errors=True)
        logger.debug("Worker resources cleaned up")


async def create_student_graph(
    datasets: list[str],
    workdir: Path,
    session_id: str | None = None,
    checkpointer: BaseCheckpointSaver | None = None,
) -> Runnable:
    """Create a student graph for getting prediction answers.

    Args:
        datasets (list[str]): Evaluation datasets.
        workdir (Path): Work directory.
        session_id (str | None, optional): Session ID. Defaults to None.

    Returns:
        Runnable: Student workflow.
    """
    wf: CompiledGraph = create_tablegpt_graph(
        llm=llm,
        pybox_manager=pybox_manager,
        workdir=workdir,
        vlm=vlm,
        session_id=session_id,
        checkpointer=checkpointer,
        model_type=model_type,
        normalize_llm=normalize_llm,
        error_trace_cleanup=settings.error_trace_cleanup,
    ).with_config(
        config={
            "configurable": {"thread_id": session_id},
        },
    )
    parent_id = str(uuid4())
    attachments = [Attachment(filename=file, mimetype="text/csv") for file in datasets]
    attachment_msg = HumanMessage(
        content="",
        additional_kwargs={
            "parent_id": parent_id,
            "attachments": attachments,
            "var_name": "df",
        },
    )
    await wf.ainvoke(
        input={
            "messages": [attachment_msg],
            "parent_id": parent_id,
            "entry_message": attachment_msg,
            "processing_stage": Stage.UPLOADED,
        }
    )
    return wf
