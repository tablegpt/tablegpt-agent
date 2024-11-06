from typing import Any

from langchain.evaluation.criteria.eval_chain import Criteria
from langchain.evaluation.scoring.eval_chain import (
    _FIND_DOUBLE_BRACKETS,
    ScoreStringResultOutputParser,
)

DEFAULT_CRITERIA = [
    Criteria.HELPFULNESS,
    Criteria.RELEVANCE,
    Criteria.CORRECTNESS,
    Criteria.DEPTH,
    Criteria.DETAIL,
]


class FloatScoreOutputParser(ScoreStringResultOutputParser):
    prefix: str = "Score:"  # Or maybe `None`?
    lower_bound: float = 0.0
    upper_bound: float = 1.0

    def parse(self, text: str) -> dict[str, Any]:
        """Parse the output text.

        Args:
            text (str): The output text to parse.

        Returns:
            dict: The parsed output.

        Raises:
            ValueError: If the verdict is invalid.
        """
        match = _FIND_DOUBLE_BRACKETS.search(text)

        if match:
            score_str = match.group(1).strip()
            score = float(score_str)
            if score > self.upper_bound or score < self.lower_bound:
                raise ValueError(  # noqa: TRY003
                    f"Invalid output: {text}. "  # noqa: EM102
                    f"Output must contain a double bracketed string with the verdict between {self.lower_bound} and {self.upper_bound}."
                )
            reason = text.rsplit(self.prefix, maxsplit=1)[0].strip()
            return {
                "reason": reason,
                "score": round(score, 2),
            }
        raise ValueError(  # noqa: TRY003
            f"Invalid output: {text}. Output must contain a double bracketed string. example: [[0.5]]"  # noqa: EM102
        )
