from __future__ import annotations

from typing import TYPE_CHECKING

from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

if TYPE_CHECKING:
    from langchain_core.language_models import BaseLanguageModel
    from langchain_core.runnables import Runnable


TRANSLATION_PROMPT = """You are a translation assistant. Translate user input directly into the primary language of the {locale} region without explanation."""


translation_prompt_template = ChatPromptTemplate.from_messages(
    [
        ("system", TRANSLATION_PROMPT),
        ("human", "{input}"),
    ]
)

output_parser = StrOutputParser()


def get_translation_chain(llm: BaseLanguageModel) -> Runnable:
    """return the guard chain runnable."""
    return translation_prompt_template | llm | output_parser
