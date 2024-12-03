from __future__ import annotations

import concurrent.futures
import os
from pathlib import Path
from typing import NamedTuple, cast

import pandas as pd


class FileEncoding(NamedTuple):
    """File encoding as the NamedTuple."""

    encoding: str | None
    """The encoding of the file."""
    confidence: float
    """The confidence of the encoding."""
    language: str | None
    """The language of the file."""


def detect_file_encodings(
    file_path: str | Path, timeout: int = 5
) -> list[FileEncoding]:
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
        try:
            encodings = future.result(timeout=timeout)
        except concurrent.futures.TimeoutError:
            raise TimeoutError(
                f"Timeout reached while detecting encoding for {file_path}"
            )

    if all(encoding["encoding"] is None for encoding in encodings):
        raise RuntimeError(f"Could not detect encoding for {file_path}")
    return [FileEncoding(**enc) for enc in encodings if enc["encoding"] is not None]


def path_from_uri(uri: str) -> Path:
    """Return a new path from the given 'file' URI.
    This is implemented in Python 3.13.
    See <https://github.com/python/cpython/pull/107640>
    and <https://github.com/python/cpython/pull/107640/files#diff-fa525485738fc33d05b06c159172ff1f319c26e88d8c6bb39f7dbaae4dc4105c>
    TODO: remove when we migrate to Python 3.13"""
    if not uri.startswith("file:"):
        raise ValueError(f"URI does not start with 'file:': {uri!r}")
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
        raise ValueError(f"URI is not absolute: {uri!r}")
    return path


def file_extention(file: str) -> str:
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
        raise ValueError(f"不支持的文件编码{e.encoding}，请转换成 utf-8 后重试")  # noqa: RUF001


def _read_df(uri: str, encoding: str = "utf-8", **kwargs) -> pd.DataFrame:
    """A simple wrapper to read different file formats into DataFrame."""
    ext = file_extention(uri).lower()
    if ext == ".csv":
        df = pd.read_csv(uri, encoding=encoding, **kwargs)
    elif ext == ".tsv":
        df = pd.read_csv(uri, sep="\t", encoding=encoding, **kwargs)
    elif ext in [".xls", ".xlsx", ".xlsm", ".xlsb", ".odf", ".ods", ".odt"]:
        # read_excel does not support 'encoding' arg, also it seems that it does not need it.
        df = pd.read_excel(uri, **kwargs)
    else:
        raise ValueError(
            f"TableGPT 目前支持 csv、tsv 以及 xlsx 文件，您上传的文件格式 {ext} 暂不支持。"  # noqa: RUF001
        )
    return df
