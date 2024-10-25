from __future__ import annotations

import concurrent.futures
import json
import os
from copy import deepcopy
from datetime import datetime
from pathlib import Path
from typing import TYPE_CHECKING, Any, NamedTuple, cast

import numpy as np
import pandas as pd

from tablegpt.errors import (
    EncodingDetectionError,
    InvalidFileURIError,
    NonAbsoluteURIError,
    UnsupportedEncodingError,
    UnsupportedFileFormatError,
)

if TYPE_CHECKING:
    from collections.abc import Sequence

    from langchain_core.documents import Document
    from langchain_core.messages import BaseMessage


def path_from_uri(uri: str) -> Path:
    """Return a new path from the given 'file' URI.
    This is implemented in Python 3.13.
    See <https://github.com/python/cpython/pull/107640>
    and <https://github.com/python/cpython/pull/107640/files#diff-fa525485738fc33d05b06c159172ff1f319c26e88d8c6bb39f7dbaae4dc4105c>
    TODO: remove when we migrate to Python 3.13"""
    if not uri.startswith("file:"):
        raise InvalidFileURIError(uri)
    path = uri[5:]
    if path[:3] == "///":
        # Remove empty authority
        path = path[2:]
    elif path[:12] == "//localhost/":
        # Remove 'localhost' authority
        path = path[11:]
    if path[:3] == "///" or (path[:1] == "/" and path[2:3] in ":|"):
        # Remove slash before DOS device/UNC path
        path = path[1:]
    if path[1:2] == "|":
        # Replace bar with colon in DOS drive
        path = path[:1] + ":" + path[2:]
    from urllib.parse import unquote_to_bytes

    path = Path(os.fsdecode(unquote_to_bytes(path)))
    if not path.is_absolute():
        raise NonAbsoluteURIError(uri)
    return path


def file_extension(file: str) -> str:
    """Get the file extension from a file name.

    Args:
        file: The name of the file.

    Returns:
        The file extension.
    """
    path = Path(file)
    return path.suffix


def list_sheets(filepath: Path) -> list[str]:
    """List all sheet names in an Excel file.

    Args:
        filepath: The path to the Excel file.

    Returns:
        A list of sheet names.
    """
    excel_file = pd.ExcelFile(filepath)
    return excel_file.sheet_names


def get_raw_table_info(
    filepath: Path,
    nrows: int = 5,
    date_format: str = "%Y-%m-%d",
) -> list[list[Any]]:
    """Reads the first nrows from the specified sheet of an Excel or CSV file.
    This function reads the data from a table stored in a file, allowing
    for the selection of a specific sheet and limiting the number of rows
    to be read.

    Args:
        filepath: The path to the file containing the table data.
        sheet_name: The name or index of the sheet within the file
            to read the data from. If not specified, the first sheet will
            be used.
        nrows: The number of rows to read from the table.
        date_format: The format of the datetime cells.

    Returns:
        list[list[Any]]: A 2D array where each sublist represents a row from the table,
        with each element in the sublist corresponding to a column value in that row.
    """
    read_kwargs = {"nrows": nrows, "header": None}

    df = read_df(filepath, **read_kwargs)

    # Replace NaN with None and format datetime cells
    df = df.where(df.notnull(), None).map(
        lambda cell: (
            cell.strftime(date_format) if isinstance(cell, (pd.Timestamp, datetime)) and pd.notnull(cell) else cell
        )
    )
    # Convert DataFrame to a list of lists
    return df.replace({np.nan: None}).values.tolist()


def read_df(uri: str, *, autodetect_encoding: bool = True, **kwargs) -> pd.DataFrame:
    """A simple wrapper to read different file formats into DataFrame."""
    try:
        return _read_df(uri, **kwargs)
    except UnicodeDecodeError as e:
        if autodetect_encoding:
            detected_encodings = detect_file_encodings(path_from_uri(uri), timeout=30)
            for encoding in detected_encodings:
                try:
                    return _read_df(uri, encoding=encoding.encoding, **kwargs)
                except UnicodeDecodeError:
                    continue
        # Either we ran out of detected encoding, or autodetect_encoding is False,
        # we should raise encoding error
        raise UnsupportedEncodingError(e.encoding) from e


def _read_df(uri: str, encoding: str = "utf-8", **kwargs) -> pd.DataFrame:
    """A simple wrapper to read different file formats into DataFrame."""
    ext = file_extension(uri).lower()
    if ext == ".csv":
        df = pd.read_csv(uri, encoding=encoding, **kwargs)
    elif ext == ".tsv":
        df = pd.read_csv(uri, sep="\t", encoding=encoding, **kwargs)
    elif ext in [".xls", ".xlsx", ".xlsm", ".xlsb", ".odf", ".ods", ".odt"]:
        # read_excel does not support 'encoding' arg, also it seems that it does not need it.
        df = pd.read_excel(uri, **kwargs)
    else:
        raise UnsupportedFileFormatError(ext)
    return df


class FileEncoding(NamedTuple):
    """File encoding as the NamedTuple."""

    encoding: str | None
    """The encoding of the file."""
    confidence: float
    """The confidence of the encoding."""
    language: str | None
    """The language of the file."""


def detect_file_encodings(file_path: str | Path, timeout: int = 5) -> list[FileEncoding]:
    """Try to detect the file encoding.

    Returns a list of `FileEncoding` tuples with the detected encodings ordered
    by confidence.

    Args:
        file_path: The path to the file to detect the encoding for.
        timeout: The timeout in seconds for the encoding detection.
    """
    import chardet

    file_path = str(file_path)

    def read_and_detect(file_path: str) -> list[dict]:
        with open(file_path, "rb") as f:
            rawdata = f.read()
        return cast(list[dict], chardet.detect_all(rawdata))

    with concurrent.futures.ThreadPoolExecutor() as executor:
        future = executor.submit(read_and_detect, file_path)
        encodings = future.result(timeout=timeout)

    if all(encoding["encoding"] is None for encoding in encodings):
        raise EncodingDetectionError(file_path)
    return [FileEncoding(**enc) for enc in encodings if enc["encoding"] is not None]


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


def filter_contents(messages: list[BaseMessage], keep: Sequence[str] | None = None) -> list[BaseMessage]:
    """Filters a list of messages, retaining specified content parts for each message.

    This function applies the `filter_content` function to a list of `BaseMessage` instances,
    ensuring that only the specified content types are retained across all messages. If no specific
    types are provided to keep, the function defaults to retaining all 'text' parts.

    Parameters:
    ----------
    messages : list[BaseMessage]
        A list of message objects containing content to be filtered.

    keep : Sequence[str] | None, optional
        A sequence of content types to retain for each message. If None, only 'text' parts are kept.
        Defaults to None.

    Returns:
    -------
    list[BaseMessage]
        A new list of message instances with filtered content for each message.

    Notes:
    -----
    - Each message in the input list is processed individually.
    - If the content of a message is a string or a list of strings, it is returned as-is without filtering.
    - If the content of a message is a list of dictionaries, only those with a 'type' in the `keep` set are retained.
    """
    # Make sure 'text' parts are always keeped.
    if not keep:
        keep = {"text"}
    else:
        keep: set = set(keep)
        keep.add("text")

    return [filter_content(msg, keep) for msg in messages]


def filter_content(message: BaseMessage, keep: Sequence[str] | None = None) -> BaseMessage:
    """Filters the content of a message, ensuring that only specified parts are retained.

    This function examines the `content` of a `BaseMessage` and filters it based on the provided
    `keep` criteria. If no specific parts are specified to keep, the function defaults to retaining
    all 'text' parts. The function ensures that the original message is not modified, returning a
    new instance instead.

    Parameters:
    ----------
    message : BaseMessage
        The message object containing the content to be filtered.

    keep : Sequence[str] | None, optional
        A sequence of content types to retain. If None, only 'text' parts are kept.
        Defaults to None.

    Returns:
    -------
    BaseMessage
        A new message instance with filtered content.

    Notes:
    -----
    - If the content is a string or a list of strings, it is returned as-is without filtering.
    - If the content is a list of dictionaries, only those with a 'type' in the `keep` set are retained.
    """
    # Make sure 'text' parts are always keeped.
    if not keep:
        keep = {"text"}
    else:
        keep: set = set(keep)
        keep.add("text")

    if isinstance(message.content, str):
        # Content is str, return directly
        return message

    if all(isinstance(part, str) for part in message.content):
        # Content is a list of str, return directly
        return message

    # Content is a list of dict, perform filtering.
    # We don't want to modify on the original message, as it will be persisted in agent state.
    cloned = deepcopy(message)
    cloned.content = []
    for part in message.content:
        if not isinstance(part, dict) or part.get("type") in keep:
            cloned.content.append(part)
    return cloned
