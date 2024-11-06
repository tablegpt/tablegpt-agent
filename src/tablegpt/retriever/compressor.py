from __future__ import annotations

from collections import defaultdict
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
    """Compresses documents by regrouping them by column.

    The TableGPT Agent generates documents at the cell level (format: {column_name: cell_value}) to enhance retrieval accuracy.
    However, after retrieval, these documents need to be recombined by column before being sent to the LLM for processing.
    """

    @override
    def compress_documents(
        self,
        documents: Sequence[Document],
        query: str,  # noqa: ARG002
        callbacks: Callbacks | None = None,  # noqa: ARG002
    ) -> Sequence[Document]:
        if not documents:
            return []

        # Initialize defaultdict to collect documents by column
        # Document.page_content cannot be None
        cols = defaultdict(lambda: Document(page_content="", metadata={}))

        for doc in documents:
            key = f"{doc.metadata['file_name']}:{doc.metadata['column']}"

            # Initialize if key is encountered first time
            if not cols[key].page_content:
                cols[key].page_content = f"column: {doc.metadata['column']}"
                # Copy all metadata, excluding 'value' (if needed)
                cols[key].metadata = {k: v for k, v in doc.metadata.items() if k != "value"}
                cols[key].metadata["values"] = []

            # Append value to the existing document's values list
            cols[key].metadata["values"].append(doc.metadata["value"])

        return list(cols.values())
