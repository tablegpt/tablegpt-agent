from __future__ import annotations

from typing import TYPE_CHECKING

from langchain_core.output_parsers import BaseTransformOutputParser
from langchain_core.prompts import ChatPromptTemplate

if TYPE_CHECKING:
    from langchain_core.language_models import BaseLanguageModel
    from langchain_core.runnables import Runnable


# See <https://huggingface.co/meta-llama/Llama-Guard-3-8B>
hazard_categories = {
    "S1": "Violent Crimes: Responses that enable, encourage, or endorse the commission of violent crimes, including: (1) unlawful violence toward people (ex: terrorism, genocide, murder, hate-motivated violent crimes, child abuse, assault, battery, kidnapping) and (2) unlawful violence toward animals (ex: animal abuse)",
    "S2": "Non-Violent Crimes: Responses that enable, encourage, or endorse the commission of non-violent crimes, including: (1) personal crimes (ex: labor trafficking, threats, intimidation, hate-motivated non-violent crimes), (2) financial crimes (ex: fraud, scams, money laundering), (3) property crimes (ex: theft, arson, vandalism), (4) drug crimes (ex: creating or using regulated substances), (5) weapons crimes (ex: producing unlicensed firearms), and (6) cyber crimes (ex: hacking)",
    "S3": "Sex-Related Crimes: Responses that enable, encourage, or endorse the commission of sex-related crimes, including: (1) sex trafficking, (2) sexual assault (ex: rape), (3) sexual harassment (physical, verbal, or visual), and (4) prostitution",
    "S4": "Child Sexual Exploitation: Responses that contain, describe, enable, encourage, or endorse the sexual abuse of children",
    "S5": "Defamation: Responses that are both verifiably false and likely to injure a living person's reputation",
    "S6": "Specialized Advice: Responses that contain specialized financial, medical, or legal advice, or that indicate dangerous activities or objects are safe",
    "S7": "Privacy: Responses that contain sensitive, nonpublic personal information that could undermine someone's physical, digital, or financial security",
    "S8": "Intellectual Property: Responses that may violate the intellectual property rights of any third party",
    "S9": "Indiscriminate Weapons: Responses that enable, encourage, or endorse the creation of indiscriminate weapons, including: (1) chemical weapons (ex: nerve gas), (2) biological weapons (ex: anthrax), (3) radiological weapons (ex: cobalt bombs), (4) nuclear weapons (ex: fission bombs), and (5) high-yield explosive weapons (ex: cluster munitions)",
    "S10": "Hate: Responses that demean or dehumanize people on the basis of their sensitive, personal characteristics (i.e., race, color, ethnicity, national origin, disability, religious affiliation, caste, sexual orientation, sex, gender identity, and/or serious disease)",
    "S11": "Suicide & Self-Harm: Responses that enable, encourage, or endorse acts of intentional self-harm, including: (1) suicide, (2) self-injury (ex: cutting), and (3) disordered eating",
    "S12": "Sexual Content: Responses that contain erotica",
    "S13": "Elections: Responses that contain factually incorrect information about electoral systems and processes, including in the time, place, or manner of voting in civic elections",
    "S14": "Code Interpreter Abuse: Responses that seek to abuse code interpreters, including those that enable denial of service attacks, container escapes or privilege escalation exploits",
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
            return "unsafe", category
        return "unknown", None


tmpl = ChatPromptTemplate.from_messages(
    [
        ("placeholder", "{messages}"),
    ]
)


output_parse = HazardOutputParser()


def create_hazard_classifier(llm: BaseLanguageModel) -> Runnable:
    """return the guard chain runnable."""
    return tmpl | llm | output_parse
