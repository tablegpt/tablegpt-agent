from __future__ import annotations

from datetime import date  # noqa: TCH003
from typing import TYPE_CHECKING

from langchain_core.messages import BaseMessage  # noqa: TCH002
from langgraph.graph import END, START, MessagesState, StateGraph

from tablegpt.agent.data_analyzer import TruncationConfig, create_data_analyze_workflow
from tablegpt.agent.file_reading import Stage, create_file_reading_workflow

if TYPE_CHECKING:
    from pathlib import Path

    from langchain_core.language_models import BaseLanguageModel
    from langchain_core.retrievers import BaseRetriever
    from langchain_core.runnables import Runnable
    from langgraph.checkpoint.base import BaseCheckpointSaver
    from langgraph.graph.state import CompiledStateGraph
    from pybox.base import BasePyBoxManager


class AgentState(MessagesState):
    # This is a bit of a hack to pass parent id to the agent state
    # But it act as the group id of all messages generated by the agent
    # This will be used in subgraphs
    parent_id: str | None
    # Current Date
    date: date
    # The message that we received from the user, act as an entry point
    entry_message: BaseMessage
    processing_stage: Stage


def create_tablegpt_graph(
    llm: BaseLanguageModel,
    pybox_manager: BasePyBoxManager,
    *,
    session_id: str | None = None,
    workdir: Path | None = None,
    error_trace_cleanup: bool = False,
    nlines: int | None = None,
    vlm: BaseLanguageModel | None = None,
    safety_llm: Runnable | None = None,
    dataset_retriever: BaseRetriever | None = None,
    normalize_llm: BaseLanguageModel | None = None,
    locale: str | None = None,
    checkpointer: BaseCheckpointSaver | None = None,
    llm_truncation_config: TruncationConfig | None = None,
    vlm_truncation_config: TruncationConfig | None = None,
    verbose: bool = False,
) -> CompiledStateGraph:
    """Creates a state graph for processing datasets.

    This function orchestrates the creation of a workflow for handling table data.
    It sets up nodes for reading files and analyzing data based on provided parameters.
    The graph dynamically routes based on the presence of file attachments in the input state.

    Args:
        llm (Runnable): The primary language model for processing user input.
        pybox_manager (BasePyBoxManager):  A python code sandbox delegator, used to execute the data analysis code generated by llm.
        session_id (str | None, optional): An optional session identifier used to associate with `pybox`. Defaults to None.
        workdir (Path | None, optional): The working directory for `pybox` operations. Defaults to None.
        error_trace_cleanup (bool, optional): Flag to clean up error traces. Defaults to False.
        nlines (int | None, optional): Number of lines to read for preview. Defaults to None.
        vlm (BaseLanguageModel | None, optional): Optional vision language model for processing images. Defaults to None.
        safety_llm (Runnable | None, optional): Model used for safety classification of inputs. Defaults to None.
        dataset_retriever (BaseRetriever | None, optional): Component to retrieve datasets. Defaults to None.
        normalize_llm (BaseLanguageModel | None, optional): Model for data normalization tasks. Defaults to None.
        locate (str | None, optional): The locale of the user. Defaults to None.
        checkpointer (BaseCheckpointSaver | None, optional): Component for saving checkpoints. Defaults to None.
        llm_truncation_config (TruncationConfig | None, optional): Truncation config for LLM. Defaults to None.
        vlm_truncation_config (TruncationConfig | None, optional): Truncation config for VLM. Defaults to None.
        verbose (bool, optional): Flag to enable verbose logging. Defaults to False.

    Returns:
        CompiledStateGraph: A compiled state graph representing the table processing workflow.
    """
    workflow = StateGraph(AgentState)
    file_reading_graph = create_file_reading_workflow(
        nlines=nlines,
        llm=llm,
        pybox_manager=pybox_manager,
        workdir=workdir,
        session_id=session_id,
        normalize_llm=normalize_llm,
        locale=locale,
        verbose=verbose,
    )
    data_analyze_graph = create_data_analyze_workflow(
        llm=llm,
        pybox_manager=pybox_manager,
        workdir=workdir,
        session_id=session_id,
        error_trace_cleanup=error_trace_cleanup,
        vlm=vlm,
        safety_llm=safety_llm,
        dataset_retriever=dataset_retriever,
        llm_truncation_config=llm_truncation_config,
        vlm_truncation_config=vlm_truncation_config,
        verbose=verbose,
    )

    def router(state: AgentState) -> str:
        # Must have at least one message when entering this router
        last_message = state["messages"][-1]
        if last_message.additional_kwargs.get("attachments"):
            return "file_reading_graph"
        return "data_analyze_graph"

    workflow.add_node("file_reading_graph", file_reading_graph)
    workflow.add_node("data_analyze_graph", data_analyze_graph)

    workflow.add_conditional_edges(START, router)
    workflow.add_edge("file_reading_graph", END)
    workflow.add_edge("data_analyze_graph", END)

    return workflow.compile(checkpointer=checkpointer, debug=verbose)
