import logging
import sys
from pathlib import Path

import pandas as pd
from langchain_core.output_parsers.list import NumberedListOutputParser
from langchain_core.prompts.chat import ChatPromptTemplate
from langchain_openai import ChatOpenAI

logger = logging.getLogger(__name__)


INSTRUCTION = """You are a decision maker, tasked with generating diverse and insightful questions to uncover business value based on the provided datasets. These questions should be designed to be answerable using the information within the datasets.

## Datasets Description

{description}

## Provided Data

You are provided with the following datasets in the form of pandas DataFrame:

{df}


## Task

Ask new questions that either:
- Explore new aspects of the data that have not been covered by the previous questions.
- Refine or build upon previous questions to gain deeper insights.

## Notes

- Wrap your response in a numbered list.
- Ensure the questions cover a wide range of business logic and perspectives.
- Questions must be strictly answerable using the provided datasets. Avoid using business logic or information not inferable from the datasets.
- Focus on practical and relevant real-world business scenarios.
- All questions MUST be asked in Chinese.
"""


tmpl = ChatPromptTemplate.from_messages(
    [
        ("user", INSTRUCTION),
    ]
)

llm = ChatOpenAI(
    openai_api_base="http://127.0.0.1:8080/v1",
    openai_api_key="none",
    model_name="model_name",
    temperature=0.5,
    max_tokens=1024,
    verbose=True,
)


# We might want a multi-fallback output parser to combine these output parsers:
# - langchain_core.output_parsers.list.CommaSeparatedListOutputParser
# - langchain_core.output_parsers.list.NumberedListOutputParser
# - langchain_core.output_parsers.list.MarkdownListOutputParser
chain = tmpl | llm | NumberedListOutputParser()


def main(dataset_path, questions_path: Path, description: str, *, nrows: int = 3):
    """Generate questions related to the given dataframe."""
    pd.set_option("display.max_columns", None)
    if not questions_path.exists():
        logger.info("questions_path does not exist. Creating a new file.")
        questions_path.touch(mode=0o644)
    elif not questions_path.is_file():
        logger.error("Only supports file IO for now.")
        sys.exit(1)

    df = pd.read_csv(dataset_path, nrows=nrows)

    # previous_questions = questions_path.read_text(encoding="utf-8")

    new_questions: list[str] = chain.invoke(
        {
            "df": df.head(nrows),
            "description": description,
        }
    )

    with questions_path.open(mode="a+", encoding="utf-8") as f:
        for question in new_questions:
            f.write(question + "\n")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Generate questions based on the given dataset.")
    parser.add_argument(
        "--dataset",
        required=True,
        help="dataset file path",
    )  # path to the csv file
    parser.add_argument(
        "-q",
        "--questions",
        required=True,
        help="",
    )  # path to the question text file
    parser.add_argument(
        "--dataset-description",
        required=True,
        help="",
    )  # description of the dataset

    args = parser.parse_args()

    main(args.dataset, Path(args.questions), description=args.dataset_description)
