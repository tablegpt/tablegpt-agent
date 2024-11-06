from __future__ import annotations

from datetime import date
from typing import TYPE_CHECKING, TypedDict
from uuid import uuid4

from langchain_core.messages import HumanMessage
from langgraph.graph import END, START, StateGraph

if TYPE_CHECKING:
    from langchain_core.runnables import Runnable


class AgentState(TypedDict):
    input: str
    reference_answer: str | None = None
    criteria: list[str] | None = None
    redlines: list[str] | None = None
    student_answer: str | None = None
    grader_result: dict | None = None


def create_eval_workflow(
    student: Runnable,
    grader: Runnable,
) -> Runnable:
    """Create a runnable that evaluates the student's answer using the grader.

    Args:
        student (Runnable): Runnable used to predict the student's answer.
        grader (Runnable): Runnable used to grade the student's answer.

    Returns:
        Runnable: Evaluation workflow
    """

    async def arun_student_graph(data: AgentState) -> dict[str, str]:
        student_state = await student.ainvoke(
            input={
                "parent_id": str(uuid4()),
                "messages": [HumanMessage(content=data["input"])],
                "date": date.today(),  # noqa: DTZ011
            },
        )
        student_answer = student_state["messages"][-1]
        return {"student_answer": student_answer.content}

    async def arun_grader_chain(data: AgentState) -> dict[str, dict]:
        result = await grader.ainvoke(
            {
                "criteria": data["criteria"],
                "redlines": data["redlines"],
                "question": data["input"],
                "reference_answer": data["reference_answer"],
                "answer": data["student_answer"],
            },
        )
        grader_result = {
            "score": result["score"],
            "explaination": result["reason"],
        }
        return {"grader_result": grader_result}

    workflow = StateGraph(AgentState)

    workflow.add_node("arun_student_graph", arun_student_graph)
    workflow.add_node("arun_grader_chain", arun_grader_chain)

    workflow.add_edge(START, "arun_student_graph")
    workflow.add_edge("arun_student_graph", "arun_grader_chain")
    workflow.add_edge("arun_grader_chain", END)

    return workflow.compile()
