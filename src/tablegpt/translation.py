from __future__ import annotations

from typing import TYPE_CHECKING

from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

if TYPE_CHECKING:
    from langchain_core.language_models import BaseLanguageModel
    from langchain_core.runnables import Runnable


prompt_template = ChatPromptTemplate.from_messages(
    [
        (
            "system",
            "You are a translation assistant. Translate user input directly into the primary language of the {locale} region without explanation.",
        ),
        ("user", "{input}"),
    ]
)


def create_translator(llm: BaseLanguageModel) -> Runnable:
    """return the guard chain runnable."""
    return prompt_template | llm | StrOutputParser()
