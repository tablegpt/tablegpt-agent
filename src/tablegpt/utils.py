from __future__ import annotations

import concurrent.futures
import os
from copy import deepcopy
from pathlib import Path
from typing import TYPE_CHECKING, NamedTuple, cast

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

    from langchain_core.messages import BaseMessage


def path_from_uri(uri: str) -> Path:
    """Return a new path from the given 'file' URI.

    This helper function is designed for use with Python versions earlier than 3.13.
    For Python 3.13 and later, this functionality is built-in and you should use `pathlib.Path.from_uri()` instead.

    References:
    - Pull Request: <https://github.com/python/cpython/pull/107640>
    - Relevant Code Changes: <https://github.com/python/cpython/pull/107640/files#diff-fa525485738fc33d05b06c159172ff1f319c26e88d8c6bb39f7dbaae4dc4105c>

    Returns:
        pathlib.Path: A path object representing the given 'file' URI.
    """
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


def read_df(uri: str, *, autodetect_encoding: bool = True, **kwargs) -> pd.DataFrame:
    """Reads a file into a Pandas DataFrame, supporting multiple file formats and optional automatic encoding detection.

    Args:
        uri (str): The URI or file path of the file to be read. Supported formats depend on the underlying `_read_df` function.
        autodetect_encoding (bool, optional): Whether to attempt automatic detection of the file's encoding in case
            of a UnicodeDecodeError. Defaults to True.
        **kwargs: Additional keyword arguments passed to the `_read_df` function.

    Returns:
        pd.DataFrame: The loaded DataFrame containing the data from the specified file.

    Raises:
        UnsupportedEncodingError: If encoding detection fails or all detected encodings result in decoding errors.
        UnicodeDecodeError: If `autodetect_encoding` is set to False and the file cannot be read with the provided or default encoding.

    Notes:
        - The `_read_df` function is expected to handle the actual file parsing and support various formats,
          such as CSV, Excel, JSON, etc.
        - If `autodetect_encoding` is True, the function uses `detect_file_encodings` to detect potential encodings
          and retries reading the file using these encodings. If all attempts fail, an `UnsupportedEncodingError` is raised.
        - The `detect_file_encodings` function uses a 30-second timeout for encoding detection.
    """
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
    """Reads a file into a pandas DataFrame, supporting various file formats.

    Supported formats:
    - CSV files (detected by .csv extension).
    - TSV files (detected by .tsv extension).
    - Excel files (detected by extensions: .xls, .xlsx, .xlsm, .xlsb, .odf, .ods, .odt).

    Parameters:
    - uri (str): Path to the file.
    - encoding (str): Encoding of the file (default is "utf-8"). Ignored for Excel files.
    - **kwargs: Additional arguments to pass to pandas' read functions.

    Returns:
    - pd.DataFrame: The loaded data as a DataFrame.

    Raises:
    - UnsupportedFileFormatError: If the file format is not supported.

    Note:
    - Files without an extension or unsupported extensions will raise an error.
    - The `read_excel` method does not require an `encoding` parameter.

    Example:
        df = _read_df("data.csv", encoding="utf-8", delimiter=";")
    """
    ext = file_extension(uri).lower()
    if ext == ".csv":
        return pd.read_csv(uri, encoding=encoding, **kwargs)
    if ext == ".tsv":
        return pd.read_csv(uri, sep="\t", encoding=encoding, **kwargs)
    if ext in {".xls", ".xlsx", ".xlsm", ".xlsb", ".odf", ".ods", ".odt"}:
        # read_excel does not support 'encoding' arg, also it seems that it does not need it.
        return pd.read_excel(uri, **kwargs)
    raise UnsupportedFileFormatError(ext)


class FileEncoding(NamedTuple):
    """File encoding as the NamedTuple."""

    encoding: str | None
    """The encoding of the file."""
    confidence: float
    """The confidence of the encoding."""
    language: str | None
    """The language of the file."""


def detect_file_encodings(file_path: str | Path, timeout: int = 5) -> list[FileEncoding]:
    """Detect the encoding(s) of a file.

    Attempts to detect the encoding of a given file by analyzing its raw byte content.
    Returns a list of detected encodings, ordered by confidence.

    Args:
        file_path (str | Path): The path to the file whose encoding is to be detected.
        timeout (int): The maximum number of seconds to wait for the encoding detection to complete. Default is 5 seconds.

    Returns:
        List[FileEncoding]: A list of `FileEncoding` objects, ordered by the confidence of the detected encoding.

    Raises:
        EncodingDetectionError: If no encoding can be detected or if an error occurs during the file reading process.
    """
    from chardet import detect_all

    file_path = str(file_path)

    def read_and_detect(file_path: str) -> list[dict]:
        with open(file_path, "rb") as f:
            rawdata = f.read()
        return cast(list[dict], detect_all(rawdata))

    with concurrent.futures.ThreadPoolExecutor() as executor:
        future = executor.submit(read_and_detect, file_path)
        encodings = future.result(timeout=timeout)

    if all(encoding["encoding"] is None for encoding in encodings):
        raise EncodingDetectionError(file_path)
    return [FileEncoding(**enc) for enc in encodings if enc["encoding"] is not None]


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
    keep = set(keep or ["text"])

    # If content is a string or a list of all strings, no filtering is necessary.
    if isinstance(message.content, str) or all(isinstance(part, str) for part in message.content):
        return message

    # Otherwise, perform filtering.
    filtered_content = [part for part in message.content if not isinstance(part, dict) or part.get("type") in keep]

    # If the filtered content is the same as the original, return the message as-is.
    if filtered_content == message.content:
        return message

    # Clone and update the message only if changes are necessary.
    cloned_message = deepcopy(message)
    cloned_message.content = filtered_content

    return cloned_message
