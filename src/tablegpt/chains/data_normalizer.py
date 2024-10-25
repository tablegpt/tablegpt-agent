from __future__ import annotations

import ast
import re
import textwrap
from operator import itemgetter
from re import Pattern
from typing import TYPE_CHECKING, Any

import pandas as pd
from langchain_core.exceptions import OutputParserException
from langchain_core.output_parsers import BaseTransformOutputParser, StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import Runnable, RunnableLambda

from tablegpt.errors import SimpleOutputParserException

if TYPE_CHECKING:
    from langchain_core.language_models import BaseLanguageModel


MIN_ROWS = 2


def seq_to_md(raw_table_info: list[list[Any]]) -> str:
    """Convert a 2D list of table data to a Markdown-formatted string.
    This function takes a list of lists representing table data, where each sublist
    corresponds to a row and each element within a sublist corresponds to a column
    value. It converts this data into a pandas DataFrame and then returns the
    DataFrame in Markdown table format.

    Args:
        raw_table_info: A 2D array where each sublist represents a row from the table,
        with each element in the sublist corresponding to a column value in that row.

    Returns:
        str: A string containing the Markdown representation of the table.
    """
    if len(raw_table_info) < MIN_ROWS:
        raise ValueError(  # noqa
            "Input must contain at least one header row and one data row."  # noqa
        )

    headers = raw_table_info[0]
    data_rows = raw_table_info[1:]
    try:
        df = pd.DataFrame(data_rows, columns=headers)
    except Exception as e:
        raise ValueError(  # noqa
            "Failed to format DataFrame using LLM-generated results."  # noqa
        ) from e
    return df.to_markdown()


def is_split(origin: list[list[Any]], resp: list[list[Any]]) -> tuple[int, str]:
    """Determine if the original table has been split into multiple rows.
    This function is used for specific optimizations for horizontal sub-tables.
    It compares the number of columns in the original table to the number of
    columns in the transformed table to determine if the original table has
    been splitted.

    Args:
        origin (list of lists): The original table data, where each sublist
            represents a row with each element being a column value.
        resp (list of lists): The transformed table data, with the same structure
            as the original table.

    Returns:
        tuple: A tuple containing an integer and a string.
            The integer indicates the number of times the original table has been split.
            The string provides a message describing the lengths of the original and
            transformed tables.
    """
    len_o = len(origin[0])
    len_r = len(resp[0])
    split_num = len_o // len_r
    text = f"length of original table is {len_o}, length of transformed table is {len_r}"
    return split_num, text


# region table reformat


class EvalResultError(OutputParserException):
    def __init__(self, text: str):
        super().__init__(f"Could not eval extraction: {text}")


class OutputTypeError(OutputParserException):
    def __init__(self, text: str, expected_type: str):
        super().__init__(f"The parsed result is not of type {expected_type}. {text}")


class ListListOutputParser(BaseTransformOutputParser[list[list[Any]]]):
    # TODO: this regex has lot of bugs.
    pattern: Pattern = re.compile(r"\[\s*(?:\[\s*(.*?)\s*\]\s*)*\,?\]")
    """Explanation of the regex:
    - \\[ and \\]: Match the outer square brackets of the list.
    - \\s*: Matches zero or more whitespace characters (spaces, tabs, etc.) between and around the elements.
    - (?: ... )*: A non-capturing group that matches inner lists. The * allows matching zero or more inner lists.
        - \\[\\s*(.*?)\\s*\\]: Matches the inner square brackets of a list and allows optional spaces inside.
            - (.*?): Non-greedy match for the elements inside the inner lists, capturing the contents lazily.
        - \\s*: Matches optional spaces around the elements within the inner list.
    - ,?: Optionally matches a comma after the inner lists, which could exist in some cases (like when lists are separated by commas).
    """

    def parse(self, text: str) -> list[list[Any]]:
        if (match := self.pattern.search(text)) is not None:
            matched_text = match.group(0)
            try:
                parsed_result = ast.literal_eval(matched_text)
            except Exception as e:
                raise EvalResultError(matched_text) from e

            if isinstance(parsed_result, list) and all(isinstance(item, list) for item in parsed_result):
                return parsed_result
            raise OutputTypeError(text, "list[list]")
        raise SimpleOutputParserException(text)


class ListTupleOutputParser(BaseTransformOutputParser[list[list[Any]]]):
    # TODO: this regex has lot of bugs.
    pattern: Pattern = re.compile(r"\[\s*(?:\(\s*(.*?)\s*\)\s*)*\,?\]")
    """Explanation of the regex:
    - \\[ and \\]: Match the outer square brackets of the list.
    - \\s*: Matches zero or more whitespace characters (spaces, tabs, etc.) between and around the elements.
    - (?: ... )*: A non-capturing group that matches inner tuples. The * allows for zero or more tuples.
        - \\(\\s*(.*?)\\s*\\): Matches the inner parentheses of a tuple and allows optional spaces inside.
            - (.*?): Non-greedy match for the elements inside the tuple, capturing the contents lazily.
        - \\s*: Matches optional spaces around the elements within the tuple.
    - ,?: Optionally matches a comma after the inner lists, which could exist in some cases (like when lists are separated by commas).
    """

    def parse(self, text: str) -> list[list[Any]]:
        if (match := self.pattern.search(text)) is not None:
            matched_text = match.group(0)
            try:
                results = ast.literal_eval(matched_text)
            except Exception as e:
                raise EvalResultError(matched_text) from e
            if isinstance(results, list) and all(isinstance(item, tuple) for item in results):
                return [list(dl) for dl in results]
            raise OutputTypeError(text, "list[tuple]")
        raise SimpleOutputParserException(text)


PROMPT_TABLE_REFORMAT = """Task Description:
Please reformat the provided table from a sequence format to a normalized format. The example below illustrates the desired transformation:

Guidelines:
1. Ensure there are no hierarchical columns, no pivoting, and no separation of values and percentages across different columns.
2. Remove any redundant rows and columns.
3. Ensure that there are no duplicate column names.
4. The output should be provided as a sequence, without any Python code.

Input:{table}
Output:"""


table_reformat_prompt_template = ChatPromptTemplate.from_messages(
    [
        ("system", PROMPT_TABLE_REFORMAT),
    ]
)


def get_table_reformat_chain(llm: BaseLanguageModel) -> Runnable:
    return table_reformat_prompt_template | llm | ListListOutputParser().with_fallbacks([ListTupleOutputParser()])


# endregion


# region transform
class NoFinalDFError(OutputParserException):
    def __init__(self):
        super().__init__("No `final_df` variable found in LLM generation.")


class NoPythonCodeError(OutputParserException):
    def __init__(self):
        super().__init__("No Python code block found in LLM generation.")


class CodeOutputParser(StrOutputParser):
    pattern: Pattern = re.compile(r"```python(.*?)```", re.DOTALL)
    suffix: str = """
if final_df.columns.tolist() == final_df.iloc[0].tolist():
    final_df = final_df.iloc[1:]
"""

    def parse(self, text: str) -> str:
        """Extract Python code from the LLM-generated result.
        This method searches for Python code blocks within a given text and
        extracts the code. It is designed to parse the output of the normalization
        chain produced by a language model.

        Returns:
            str: The extraced Python code to normalize a DataFrame
        """
        if (match := self.pattern.search(text)) is not None:
            generated_code = match.group(1).strip()
            if "final_df" not in generated_code:
                raise NoFinalDFError
            return generated_code + self.suffix
        raise NoPythonCodeError


PROMPT_TRANSFORM = """## As a seasoned Python programmer and code transformation specialist, your mission is to craft Python code that will convert the original data structure into the desired transformed format.

### Original Data Structure:
{original}

### Desired Transformed Data Structure:
{transformed}

### Target Columns:
{target_columns}

{add_info}

### Notes:
1. The original data is assumed to be loaded into a DataFrame named `df`. Do not overwrite the `df` variable.
2. Please use the following template for your code:

```python
# Step 1: Isolate the Table Header
# Utilize df.iloc to remove the unnecessary top rows and columns
{step_optional}
# Step 2: Store the Result as `final_df`

# Step 3: Rename Columns of final_df
# Adjust the column names of final_df to match {target_columns}

# Step 4: Data Processing
# Manipulate final_df to match the transformed format by applying operations such as dropna, drop_duplicates, fillna, etc.
```"""

split_msg = """
# Step Optional:
# If necessary, split the df into {split_num} sub DataFrames using df.iloc[:, i:i+{length_col}]
# Rename the columns of each sub_df to {target_columns}
# Concatenate the sub-tables along `axis=0`

"""


transform_prompt_template = ChatPromptTemplate.from_messages(
    [
        ("system", PROMPT_TRANSFORM),
    ]
)
# endregion


def get_data_normalize_chain(llm: BaseLanguageModel) -> Runnable:
    """Input a csv or excel file and output python code to transform the table."""
    return (
        {
            "original": itemgetter("table") | RunnableLambda(seq_to_md),
            "transformed": itemgetter("reformatted_table") | RunnableLambda(seq_to_md),
            "target_columns": itemgetter("reformatted_table") | RunnableLambda(lambda x: x[0]),
            "step_optional": (
                {
                    "reformatted_table": itemgetter("reformatted_table"),
                    "raw_table_info": itemgetter("table"),
                }
                | RunnableLambda(
                    lambda x: (
                        split_msg.format(
                            split_num=is_split(x["raw_table_info"], x["reformatted_table"])[0],
                            length_col=lambda x: len(x[0]),
                            target_columns=lambda x: x[0],
                        )
                        if is_split(x["raw_table_info"], x["reformatted_table"])[0] > 1
                        else ""
                    )
                )
            ),
            "add_info": {
                "reformatted_table": itemgetter("reformatted_table"),
                "raw_table_info": itemgetter("table"),
            }
            | RunnableLambda(lambda x: is_split(x["raw_table_info"], x["reformatted_table"])[1]),
        }
        | transform_prompt_template
        | llm
        | CodeOutputParser()
    )


def wrap_normalize_code(var_name: str, normalization_code: str) -> str:
    """Wraps normalization code in a try-except block for data normalization.

    This function takes a variable name and a string containing normalization code,
    and wraps it in a structured format that includes error handling. The resulting
    code block will attempt to create a copy of the specified DataFrame, apply the
    normalization code, and reassign the original variable. If an exception occurs,
    it will print an error message and allow the program to proceed with the original
    DataFrame.

    Parameters:
    ----------
    var_name : str
        The name of the variable representing the DataFrame to be normalized.

    normalization_code : str
        The normalization code to be applied to the DataFrame, formatted as a string.

    Returns:
    -------
    str
        A formatted string containing the wrapped normalization code, including
        error handling.

    Notes:
    -----
    - The resulting code is intended to be executed in a Python environment where
      the specified DataFrame variable exists.
    """
    return f"""# Normalize the data
try:
    df = {var_name}.copy()

{textwrap.indent(normalization_code, '    ')}
    # reassign {var_name} with the formatted DataFrame
    {var_name} = final_df
except Exception as e:
    # Unable to apply formatting to the original DataFrame. proceeding with the unformatted DataFrame.
    print(f"Reformat failed with error {{e}}, use the original DataFrame.")"""
