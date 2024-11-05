from operator import itemgetter

from agent_eval.grader.output_parser import FloatScoreOutputParser
from agent_eval.grader.prompt import (
    INSTRUCTION,
    format_criteria,
    format_redlines,
    format_reference_answer,
)
from langchain_core.language_models import BaseLanguageModel
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnableParallel

PROMPT = ChatPromptTemplate.from_messages([("user", INSTRUCTION)])

output_parser = FloatScoreOutputParser()


formatter = RunnableParallel(
    criteria=lambda x: (
        format_criteria(x["criteria"]) if "criteria" in x and x["criteria"] else ""
    ),
    redlines=lambda x: (
        format_redlines(x["redlines"]) if "redlines" in x and x["redlines"] else ""
    ),
    reference_answer=lambda x: (
        format_reference_answer(x["reference_answer"])
        if "reference_answer" in x and x["reference_answer"]
        else ""
    ),
    question=itemgetter("question"),
    answer=itemgetter("answer"),
)


def grader_chain(llm: BaseLanguageModel):
    return formatter | PROMPT | llm | output_parser
