from __future__ import annotations

from pathlib import Path
from sys import version_info
from typing import TYPE_CHECKING

from langchain_core.document_loaders import BaseLoader
from langchain_core.documents import Document
from pandas.api.types import is_string_dtype

from tablegpt.utils import read_df

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


if TYPE_CHECKING:
    from collections.abc import AsyncIterator, Iterator

    from pandas import Series


class CSVLoader(BaseLoader):
    """Loads CSV or Excel files into Documents.

    This is similar with `langchain_community.document_loadsers.csv_loader.CSVLoader`.
    """

    def __init__(
        self,
        file_path: str | Path,
        extra_metadata: dict | None = None,
        encoding: str | None = None,
        *,
        autodetect_encoding: bool = False,
    ):
        """

        Args:
            file_path: The path to the CSV file.
            extra_metadata: Extra metadata to set on every document. Optional. Defaults to None.
            encoding: The encoding of the CSV file. Optional. Defaults to None.
            autodetect_encoding: Whether to try to autodetect the file encoding. Optional. Defaults to False.
        """
        self.file_path = file_path
        self.extra_metadata = {} if extra_metadata is None else extra_metadata
        if isinstance(self.file_path, Path):
            self.extra_metadata["filename"] = self.file_path.name
        else:
            self.extra_metadata["filename"] = self.file_path
        self.encoding = encoding
        self.autodetect_encoding = autodetect_encoding

    @override
    def lazy_load(self) -> Iterator[Document]:
        """A lazy loader for Documents."""
        df = read_df(self.file_path, autodetect_encoding=self.autodetect_encoding)
        for col in df.select_dtypes(exclude=["number"]).columns:
            yield from self.column2docs(df[col])

    @override
    async def alazy_load(self) -> AsyncIterator[Document]:
        """A lazy loader for Documents."""
        # TODO: pandas does not support async read_csv yet. We might need to async read the file first.
        async for doc in super().alazy_load():
            yield doc

    def column2docs(self, column: Series) -> Iterator[Document]:
        # If a string column contains NaN, it will be presented as object dtype.
        dtype = "string" if is_string_dtype(column.dropna()) else str(column.dtype)
        unique_values = column.unique()

        for value in unique_values:
            yield Document(
                page_content=f"{column.name}:{value}",
                metadata={
                    "column": column.name,
                    "dtype": dtype,
                    "n_unique": len(unique_values),
                    "value": str(value),  # may need to further consolidate
                }
                | self.extra_metadata,
            )
