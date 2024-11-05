from __future__ import annotations

from typing import TYPE_CHECKING

from langchain_core.output_parsers import BaseTransformOutputParser
from langchain_core.prompts import ChatPromptTemplate

if TYPE_CHECKING:
    from langchain_core.language_models import BaseLanguageModel
    from langchain_core.runnables import Runnable


# See <https://huggingface.co/meta-llama/Llama-Guard-3-8B>
hazard_categories = {
    "S1": "Violent Crimes",
    "S2": "Non-Violent Crimes",
    "S3": "Sex-Related Crimes",
    "S4": "Child Sexual Exploitation",
    "S5": "Defamation",
    "S6": "Specialized Advice",
    "S7": "Privacy",
    "S8": "Intellectual Property",
    "S9": "Indiscriminate Weapons",
    "S10": "Hate",
    "S11": "Suicide & Self-Harm",
    "S12": "Sexual Content",
    "S13": "Elections",
    "S14": "Code Interpreter Abuse",
}


class HazardOutputParser(BaseTransformOutputParser[tuple[str, str | None]]):
    def parse(self, text: str) -> tuple[str, str | None]:
        """Parse the output of the guard model.

        Returns:
            tuple[str, str | None]: A tuple where the first element is the safety flag ("safe", "unsafe", "unknown") and the second element is
            the risk category if applicable, otherwise `None`.
        """
        text = text.strip()

        if "\n" not in text:
            if text.lower() == "safe":
                return "safe", None
            return "unknown", None

        flag, category = text.split("\n", 1)
        if flag.lower() == "unsafe":
            return "unsafe", hazard_categories.get(category)
        return "unknown", None


tmpl = ChatPromptTemplate.from_messages(
    [
        ("user", "{input}"),
    ]
)


output_parse = HazardOutputParser()


def create_hazard_classifier(llm: BaseLanguageModel) -> Runnable:
    """return the guard chain runnable."""
    return tmpl | llm | output_parse
