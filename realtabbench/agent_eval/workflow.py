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
    evaluatee_answer: str | None = None
    evaluation: dict | None = None


def create_eval_workflow(evaluatee: Runnable, evaluator: Runnable) -> Runnable:
    """Create a runnable that evaluates the evaluatee's answer using the evaluator.

    Args:
        evaluatee (Runnable): Runnable used to predict the evaluatee's answer.
        evaluator (Runnable): Runnable used to evaluate the evaluatee's answer.

    Returns:
        Runnable: Evaluation workflow
    """

    async def run_evaluatee(data: AgentState) -> dict[str, str]:
        evaluatee_state = await evaluatee.ainvoke(
            input={
                "parent_id": str(uuid4()),
                "messages": [HumanMessage(content=data["input"])],
                "date": date.today(),  # noqa: DTZ011
            },
        )
        evaluatee_answer = evaluatee_state["messages"][-1]
        return {"evaluatee_answer": evaluatee_answer.content}

    async def run_evaluator(data: AgentState) -> dict[str, dict]:
        result = await evaluator.ainvoke(
            {
                "criteria": data["criteria"],
                "redlines": data["redlines"],
                "question": data["input"],
                "reference_answer": data["reference_answer"],
                "answer": data["evaluatee_answer"],
            },
        )
        evaluation = {
            "score": result["score"],
            "explaination": result["reason"],
        }
        return {"evaluation": evaluation}

    workflow = StateGraph(AgentState)

    workflow.add_node(run_evaluatee)
    workflow.add_node(run_evaluator)

    workflow.add_edge(START, "run_evaluatee")
    workflow.add_edge("run_evaluatee", "run_evaluator")
    workflow.add_edge("run_evaluator", END)

    return workflow.compile()
