from __future__ import annotations

import concurrent.futures
import logging
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

logger = logging.getLogger(__name__)


try:
    from codeshield.cs import CodeShield
except ImportError:
    logger.warning("import `CodeShield` failed, scan llm output code will not work")

    class CodeShield:
        @classmethod
        async def scan_code(cls, code: str, language=None) -> None:  # noqa: ARG003
            return None


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


async def scan_llm_output(llm_output_code: str) -> str | None:
    result = await CodeShield.scan_code(llm_output_code)
    if result is None or not result.is_insecure:
        return None

    logger.debug("codeshield scan result: %s", str(result))

    # Handle different recommended treatments based on the scan result
    # `recommended_treatment` can have three possible states: block, warn, or ignore.
    # When `recommended_treatment` is "ignore", `is_insecure` will already be `False`, so we don't need to handle this explicitly here.
    if result.recommended_treatment == "block":
        recommended_treatment = "Code Security issues found, blocking the code."
    else:
        recommended_treatment = "Warning: The generated snippet contains insecure code."

    security_report = f"""## Security Report for Code Snippet
{recommended_treatment}
"""

    # When `is_insecure` is `True`, there should be at least one issue found.
    issue_details = "## Issue Details"
    for issue in result.issues_found:
        issue_details += f"""
    - Description: {issue.description}
    - Severity: {issue.severity}
    - Affected Line: {issue.line}
"""
    security_report += issue_details

    return security_report
