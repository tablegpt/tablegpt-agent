from __future__ import annotations

from copy import deepcopy
from dataclasses import asdict, dataclass
from datetime import date  # noqa: TCH003
from typing import TYPE_CHECKING, Callable, Literal
from uuid import uuid4

from langchain_core.messages import (
    BaseMessage,
    HumanMessage,
    SystemMessage,
    ToolMessage,
    trim_messages,
)
from langchain_core.prompts import ChatPromptTemplate
from langgraph.graph import END, START, MessagesState, StateGraph
from langgraph.prebuilt import ToolNode

from tablegpt.agent.output_parser import MarkdownOutputParser
from tablegpt.retriever import format_columns
from tablegpt.safety import create_hazard_classifier, hazard_categories
from tablegpt.tools import (
    IPythonTool,
    markdown_console_template,
    process_content,
)
from tablegpt.utils import filter_contents

if TYPE_CHECKING:
    from collections.abc import Sequence
    from pathlib import Path

    from langchain_core.agents import AgentAction, AgentFinish
    from langchain_core.language_models import BaseLanguageModel
    from langchain_core.retrievers import BaseRetriever
    from langchain_core.runnables import Runnable
    from langchain_text_splitters import TextSplitter
    from pybox.base import BasePyBoxManager


@dataclass
class TruncationConfig:
    """Configuration for message truncation, used by `langchain_core.messages.trim_messages` to control how messages are shortened."""

    token_counter: Callable[[list[BaseMessage]], int] | Callable[[BaseMessage], int] | BaseLanguageModel
    """Function or llm for counting tokens in a BaseMessage or a list of BaseMessage.
    If a BaseLanguageModel is passed in then BaseLanguageModel.get_num_tokens_from_messages() will be used.
    Set to `len` to count the number of **messages** in the chat history."""

    max_tokens: int
    """Max token count of trimmed messages."""

    strategy: Literal["first", "last"] = "last"
    """Strategy for trimming.
    - "first": Keep the first <= n_count tokens of the messages.
    - "last": Keep the last <= n_count tokens of the messages.
    Default is "last"."""

    allow_partial: bool = False
    """Whether to split a message if only part of the message can be included.
    If ``strategy="last"`` then the last partial contents of a message are included.
    If ``strategy="first"`` then the first partial contents of a message are included.
    Default is False."""

    end_on: str | type[BaseMessage] | Sequence[str | type[BaseMessage]] | None = None
    """The message type to end on. If specified then every message after the last occurrence
    of this type is ignored. If ``strategy=="last"`` then this is done before we attempt
    to get the last ``max_tokens``. If ``strategy=="first"`` then this is done after we
    get the first ``max_tokens``. Can be specified as string names (e.g. "system", "human",
    "ai", ...) or as BaseMessage classes (e.g. SystemMessage, HumanMessage, AIMessage, ...).
    Can be a single type or a list of types. Default is None."""

    start_on: str | type[BaseMessage] | Sequence[str | type[BaseMessage]] | None = None
    """The message type to start on. Should only be specified if ``strategy="last"``.
    If specified then every message before the first occurrence of this type is ignored.
    This is done after we trim the initial messages to the last ``max_tokens``. Does not
    apply to a SystemMessage at index 0 if ``include_system=True``. Can be specified as
    string names (e.g. "system", "human", "ai", ...) or as BaseMessage classes
    (e.g. SystemMessage, HumanMessage, AIMessage, ...). Can be a single type or a list
    of types. Default is None."""

    include_system: bool = False
    """Whether to keep the SystemMessage if there is one at index 0. Should only be
    specified if ``strategy="last"``. Default is False."""

    text_splitter: Callable[[str], list[str]] | TextSplitter | None = None
    """text_splitter: Function or ``langchain_text_splitters.TextSplitter`` for
    splitting the string contents of a message. Only used if
    ``allow_partial=True``. If ``strategy="last"`` then the last split tokens
    from a partial message will be included. if ``strategy=="first"`` then the
    first split tokens from a partial message will be included. Token splitter
    assumes that separators are kept, so that split contents can be directly
    concatenated to recreate the original text. Defaults to splitting on
    newlines."""


INSTRUCTION = """You are an expert Python data analyst. You approach problems through systematic thinking and rigorous reasoning. Each markdown codeblock you write will be executed in an IPython environment, and you will receive the execution output. You should provide results analysis based on the execution output. When solving problems, follow these thought processes:
## Deep Understanding
Take time to fully comprehend the problem before attempting a solution. Consider:
- What is the real question being asked?
- What are the given conditions and what do they tell us?
- Are there any special restrictions or assumptions?
- Which information is crucial and which is supplementary?
## Multi-angle Analysis
Before solving, conduct thorough analysis:
- What mathematical concepts and properties are involved?
- Can you recall similar classic problems or solution methods?
- Would diagrams or tables help visualize the problem?
- Are there special cases that need separate consideration?
## Systematic Thinking
Plan your solution path:
- Propose multiple possible approaches
- Analyze the feasibility and merits of each method
- Choose the most appropriate method and explain why
- Break complex problems into smaller, manageable steps
## Rigorous Proof
During the solution process:
- Provide solid justification for each step
- Include detailed proofs for key conclusions
- Pay attention to logical connections
- Be vigilant about potential oversights
## Repeated Verification
After completing your solution:
- Verify your results satisfy all conditions
- Check for overlooked special cases
- Consider if the solution can be optimized or simplified
- Review your reasoning process
Remember:
1. Take time to think thoroughly rather than rushing to an answer
2. Rigorously prove each key conclusion
3. Keep an open mind and try different approaches
4. Summarize valuable problem-solving methods
5. Maintain healthy skepticism and verify multiple times
6. Use the `read_df(uri: str) -> pd.DataFrame` function to read different file formats into DataFrame
7. If necessary, use `df.info()` and `df.head()` to examine the data summary and the first few rows of the data
8. When creating charts, prefer using `seaborn` library
9. If error occurred, try to fix it
Your response should reflect deep mathematical understanding and precise logical thinking, making your solution path and reasoning clear to others.
When you're ready, present your complete solution with:
- Clear problem understanding
- Detailed solution process
- Key insights
- Thorough verification
Focus on clear, logical progression of ideas and thorough explanation of your mathematical reasoning. Provide answers in the same language as the user asking the question.
Today is {date}"""

PROMPT = ChatPromptTemplate.from_messages(
    [
        ("system", INSTRUCTION),
        ("placeholder", "{messages}"),
    ]
)


def get_data_analyzer_agent(llm: BaseLanguageModel) -> Runnable:
    return PROMPT | llm | MarkdownOutputParser(language_actions={"python": "python", "py": "python"})


class AgentState(MessagesState):
    # Current Date
    date: date

    # This is a bit of a hack to pass parent id to the agent state
    # But it act as the group id of all messages generated by the agent
    parent_id: str | None


def create_data_analyze_workflow(
    llm: BaseLanguageModel,
    pybox_manager: BasePyBoxManager,
    *,
    workdir: Path | None = None,
    session_id: str | None = None,
    error_trace_cleanup: bool = False,
    vlm: BaseLanguageModel | None = None,
    safety_llm: Runnable | None = None,
    dataset_retriever: BaseRetriever | None = None,
    verbose: bool = False,
    llm_truncation_config: TruncationConfig | None = None,
    vlm_truncation_config: TruncationConfig | None = None,
) -> Runnable:
    """Creates a data analysis workflow for processing user input and datasets.

    This function constructs a state graph that orchestrates various tasks involved
    in analyzing data, including safety checks, column retrieval from datasets,
    and invoking the appropriate agent (either the standard or vision language model agent).
    The workflow is designed to handle multiple types of messages and responses.

    Args:
        llm (BaseLanguageModel): The primary language model for processing user input.
        pybox_manager (BasePyBoxManager):  A python code sandbox delegator, used to execute the data analysis code generated by llm.
        workdir (Path | None, optional): The working directory for `pybox` operations. Defaults to None.
        session_id (str | None, optional): An optional session identifier used to associate with `pybox`. Defaults to None.
        error_trace_cleanup (bool, optional): Flag to indicate if error traces should be cleaned up. Defaults to False.
        vlm (BaseLanguageModel | None, optional): Optional vision language model for processing images. Defaults to None.
        safety_llm (Runnable | None, optional): Model used for safety classification of inputs. Defaults to None.
        dataset_retriever (BaseRetriever | None, optional): Component to retrieve dataset columns based on user input. Defaults to None.
        verbose (bool, optional): Flag to enable detailed logging. Defaults to False.
        llm_truncation_config (TruncationConfig | None, optional): Truncation config for LLM. Defaults to None.
        vlm_truncation_config (TruncationConfig | None, optional): Truncation config for VLM. Defaults to None.

    Returns:
        Runnable: A runnable object representing the data analysis workflow.
    """
    agent = get_data_analyzer_agent(llm)

    vlm_agent = None
    if vlm is not None:
        vlm_agent = get_data_analyzer_agent(vlm)

    hazard_classifier = None
    if safety_llm is not None:
        hazard_classifier = create_hazard_classifier(safety_llm)

    tools = [
        IPythonTool(
            pybox_manager=pybox_manager,
            cwd=workdir,
            session_id=session_id,
            error_trace_cleanup=error_trace_cleanup,
        )
    ]
    tool_executor = ToolNode(tools)

    async def input_guard(
        state: AgentState,
    ) -> dict[str, list[BaseMessage]]:
        if hazard_classifier is not None:
            last_message = state["messages"][-1]
            flag, category = await hazard_classifier.ainvoke(input={"messages": [last_message]})
            if flag == "unsafe" and category is not None:
                last_message.additional_kwargs["hazard"] = category
                return {"messages": [last_message]}
        return {"messages": []}

    async def retrieve_columns(state: AgentState) -> dict:
        if dataset_retriever is None:
            return {"messages": []}

        last_message = state["messages"][-1]
        docs = await dataset_retriever.ainvoke(
            input=last_message.content,
        )
        formatted = format_columns(docs)
        return {
            "messages": [
                SystemMessage(
                    id=str(uuid4()),
                    content=formatted,
                    additional_kwargs={"parent_id": state["parent_id"]},
                )
            ]
        }

    async def agent_node(state: AgentState) -> dict:
        messages = state["messages"][:]
        last_message = messages[-1]
        if (
            isinstance(last_message, HumanMessage)
            and ((hazard := last_message.additional_kwargs.get("hazard")) is not None)
            and ((details := hazard_categories.get(hazard)) is not None)
        ):
            hint_message = SystemMessage(
                id=str(uuid4()),
                content=f"""The user input may contain improper content related to:
{details}

Please respond with care and professionalism. Avoid engaging with harmful or unethical content. Instead, guide the user towards more constructive and respectful communication.""",
            )
            messages.append(hint_message)

        # NOTE: If llm_truncation_config is None, we will not truncate the messages.
        windowed_messages = (
            trim_messages(messages, **asdict(llm_truncation_config))
            if isinstance(llm_truncation_config, TruncationConfig)
            else messages
        )
        # Keep only 'text' and 'table' content
        filtered_messages = filter_contents(windowed_messages, keep={"text", "table"})

        # Extract filename from attachments to content
        temp_messages = deepcopy(filtered_messages)
        for message in temp_messages:
            if attachments := message.additional_kwargs.get("attachments"):
                # TODO: We only support one attachment for now.
                message.content = f"文件名称: {attachments[0]['filename']}"

        agent_outcome: AgentAction | AgentFinish = await agent.ainvoke(
            {
                "messages": temp_messages,
                "date": state["date"],
            }
        )

        messages = []
        for message in agent_outcome.messages:
            message.additional_kwargs["parent_id"] = state["parent_id"]
            messages.append(message)
        return {"messages": messages}

    async def vlm_agent_node(state: AgentState) -> dict:
        # NOTE: If vlm_truncation_config is None, we will not truncate the messages.
        windowed_messages: list[BaseMessage] = (
            trim_messages(state["messages"], **asdict(vlm_truncation_config))
            if isinstance(vlm_truncation_config, TruncationConfig)
            else state["messages"]
        )
        # NOTE: This is hacky, but VLMs have limits on the number of images they can process.
        # First we keep only 'text' part for all windowed messages except the last one.
        filtered_messages = filter_contents(windowed_messages[:-1], keep={"text"})
        # Then we add the image content of the last message back, keep it under `max_support_images`.
        if isinstance(windowed_messages[-1].content, str):
            last_message = windowed_messages[-1]
        else:
            max_support_images = int((vlm.metadata or {}).get("max_support_images", 5))
            last_message: BaseMessage = deepcopy(windowed_messages[-1])
            last_message.content = []
            added = 0
            for part in reversed(windowed_messages[-1].content):
                if isinstance(part, str):
                    last_message.content.insert(0, part)
                    continue
                if part.get("type") == "text":
                    last_message.content.insert(0, part)
                    continue
                if part.get("type") == "image_url" and added < max_support_images:
                    last_message.content.insert(0, part)
                    added += 1
        filtered_messages.append(last_message)

        # Extract filename from attachments to content
        temp_messages = deepcopy(filtered_messages)
        for message in temp_messages:
            if attachments := message.additional_kwargs.get("attachments"):
                # TODO: We only support one attachment for now.
                message.content = f"文件名称: {attachments[0]['filename']}"

        agent_outcome: AgentAction | AgentFinish = await vlm_agent.ainvoke(
            {
                "messages": temp_messages,
                "date": state["date"],
            }
        )
        messages = []
        for message in agent_outcome.messages:
            message.additional_kwargs["parent_id"] = state["parent_id"]
            messages.append(message)
        return {"messages": messages}

    async def tool_node(state: AgentState) -> dict:
        messages: list[ToolMessage] = await tool_executor.ainvoke(state["messages"])
        for message in messages:
            message.additional_kwargs = message.additional_kwargs | {
                "parent_id": state["parent_id"],
            }
            # TODO: we assume our tool is only IPythonTool, so we can hardcode the format here.
            message.content = process_content(message.content)
            for part in message.content:
                if isinstance(part, dict) and part.get("type") == "text":
                    part["text"] = markdown_console_template.format(res=part["text"])
        return {"messages": messages}

    # I cannot use `END` as the literal hint, as:
    #  > Type arguments for "Literal" must be None, a literal value (int, bool, str, or bytes), or an enum value.
    # As `END` is just an intern string of "__end__" (See `langgraph.constants`), So I use "__end__" here.
    def should_continue(state: AgentState) -> Literal["tool_node", "__end__"]:
        # Must have at least one message when entering this router
        last_message = state["messages"][-1]
        if last_message.tool_calls:
            return "tool_node"
        return END

    def agent_selector(state: AgentState) -> Literal["agent_node", "vlm_agent_node"]:
        if vlm_agent is None:
            return "agent_node"

        # No messages yet. We should start with the default agent
        if len(state["messages"]) < 1:
            return "agent_node"

        # If the latest message contains "image/xxx" output,
        # the workflow graph shoud route to "vlm_agent"
        last_message = state["messages"][-1]
        for part in last_message.content:
            if isinstance(part, dict) and part.get("type") == "image_url":
                return "vlm_agent_node"
        return "agent_node"

    workflow = StateGraph(AgentState)

    workflow.add_node(input_guard)
    workflow.add_node(retrieve_columns)
    workflow.add_node(agent_node)
    workflow.add_node(vlm_agent_node)
    workflow.add_node(tool_node)

    workflow.add_edge(START, "input_guard")
    workflow.add_edge(START, "retrieve_columns")
    workflow.add_edge(["input_guard", "retrieve_columns"], "agent_node")

    workflow.add_conditional_edges("tool_node", agent_selector)
    workflow.add_conditional_edges("agent_node", should_continue)
    workflow.add_conditional_edges("vlm_agent_node", should_continue)
    return workflow.compile(debug=verbose)
