from __future__ import annotations

from sys import version_info
from typing import TYPE_CHECKING

from langchain_core.documents import Document
from langchain_core.documents.compressor import BaseDocumentCompressor

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


if TYPE_CHECKING:
    from collections.abc import Sequence

    from langchain_core.callbacks import Callbacks


class ColumnDocCompressor(BaseDocumentCompressor):
    @override
    def compress_documents(
        self,
        documents: Sequence[Document],
        query: str,  # noqa: ARG002
        callbacks: Callbacks | None = None,  # noqa: ARG002
    ) -> Sequence[Document]:
        # column name -> document
        # TODO: we can perform a map-reduce here.
        cols: dict[str, Document] = {}
        for doc in documents:
            key = doc.metadata["file_name"] + ":" + doc.metadata["column"]
            if key not in cols:
                # TODO: what's the difference between this and doc.copy()?
                cols[key] = Document(
                    page_content=f"column:{doc.metadata['column']}",
                    metadata={
                        "file_name": doc.metadata["file_name"],
                        "column": doc.metadata["column"],
                        "dtype": doc.metadata["dtype"],
                        "n_unique": doc.metadata["n_unique"],
                        "values": [doc.metadata["value"]],
                    },
                )
            else:
                cols[key].metadata["values"] += [doc.metadata["value"]]
        return cols.values()
