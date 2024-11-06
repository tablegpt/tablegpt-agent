from __future__ import annotations

import json
from typing import TYPE_CHECKING

from tablegpt.retriever.compressor import ColumnDocCompressor
from tablegpt.retriever.loader import CSVLoader

if TYPE_CHECKING:
    from langchain_core.documents import Document

__all__ = [
    "CSVLoader",
    "ColumnDocCompressor",
    "format_columns",
]


def format_columns(
    docs: list[Document],
    dataset_cell_length_threshold: int = 40,
    max_dataset_cells: int = 5,
) -> str:
    if not docs:
        return ""
    tables: dict = {}
    for doc in docs:
        tables.setdefault(doc.metadata["file_name"], []).append(doc)

    cols = []
    for table, t_docs in tables.items():
        cols.append(
            f"- {table}:\n"
            + "\n".join(
                f'  - {{"column": {doc.metadata["column"]}, "dtype": "{doc.metadata["dtype"]}", "values": {format_values(doc.metadata["values"], dataset_cell_length_threshold, max_dataset_cells, doc.metadata["n_unique"])}}}'
                for doc in t_docs
            )
        )

    return (
        "\nHere are some extra column information that might help you understand the dataset:\n"
        + "\n".join(cols)
        + "\n"
    )


def format_values(
    values_to_format: list[str],
    cell_length: int | None = None,
    n_to_keep: int | None = None,
    n_unique: int | None = None,
) -> str:
    """Format values into a json list string.
    Args:
        values_to_format (list[str]): A list of values to format.
        cell_length (int, optional): Maximum length of each cell. Defaults to None.
        n_to_keep (int, optional): Number of values to keep. Defaults to None.
        n_unique (int, optional): number of unique values in that column. Defaults to None.

    Returns:
        str: Formatted values as a json list string.
    """
    # Apply length limit if specified
    if n_to_keep is not None:
        values_to_format = values_to_format[:n_to_keep]

    # Apply cell length limit if specified
    if cell_length is not None:
        values_to_format = [
            value[:cell_length] + "..." if len(value) > cell_length else value for value in values_to_format
        ]

    # Convert values to JSON representation
    values_repr = json.dumps(values_to_format, ensure_ascii=False)

    # Check if unique count is specified and greater than the actual length of values
    if n_unique is not None and n_unique > len(values_to_format):
        values_repr = values_repr[:-1] + ", ...]"

    return values_repr
