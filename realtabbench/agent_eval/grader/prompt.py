INSTRUCTION = """You are a teacher grading a quiz. Start by providing a brief reason for the rating you will assign. Then, assign a rating on a scale from 0.0 to 1.0, using the format: "Score: [[score]]" (e.g., "Score: [[0.5]]").
{criteria}
{redlines}
## Quiz
Question: {question}
{reference_answer}
Answer: {answer}
"""


DEFAULT_CRITERIA_WITH_REFERENCE_ANSWER = [
    "Grade the student answers based ONLY on their factual accuracy relative to the ground truth answer.",
    "Ensure that the student answer does not contain any conflicting statements.",
    "It is OK if the student answer contains more information than the ground truth answer, as long as it is factually accurate relative to the ground truth answer.",
]


# Picked from `langchain.evaluation.criteria.eval_chain.Criteria`
DEFAULT_CRITERIA_WITHOUT_REFERENCE_ANSWER = [
    "Is the submission correct, accurate, and factual?",
    "Is the submission concise and to the point?",
    "Is the submission helpful, insightful, and appropriate?",
]


def format_criteria(criteria: list[str]) -> str:
    if not criteria:
        return ""
    return f"""## Evaluation Criteria
Consider the following criteria when assigning the rating:
{"\n".join(["- " + x for x in criteria])}
"""


def format_redlines(attentions: list[str]) -> str:
    if not attentions:
        return ""
    return f"""## Redlines
If the answer touches one of the redlines listed below, assign a score of [[0.0]] directly.
{"\n".join(["- " + x for x in attentions])}
"""


def format_reference_answer(reference_answer: str) -> str:
    if not reference_answer:
        return ""
    return f"Reference Answer: {reference_answer}"
