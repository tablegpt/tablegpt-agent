from __future__ import annotations

from sys import version_info
from typing import TYPE_CHECKING
from urllib.parse import urljoin

import aiohttp
import requests
from langchain_core.documents import Document
from langchain_core.documents.compressor import BaseDocumentCompressor
from pydantic import BaseModel

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


if TYPE_CHECKING:
    from collections.abc import Sequence

    from langchain_core.callbacks import Callbacks


class RerankResponseEntry(BaseModel):
    """Rerank response entry."""

    index: int
    score: float


class HuggingfaceTEIReranker(BaseDocumentCompressor):
    """Document compressor using Flashrank interface."""

    base_url: str
    batch_size: int = 32
    """client batch size. text-embedding-inference defaults to 32."""
    score_threshold: float | None = None

    @override
    def compress_documents(
        self,
        documents: Sequence[Document],
        query: str,
        callbacks: Callbacks | None = None,  # noqa: ARG002
    ) -> Sequence[Document]:
        docs_chunks = self._split_documents(documents)
        responses = []
        for chunk in docs_chunks:
            idxed_documents = {i: doc for i, doc in enumerate(chunk) if doc.page_content}

            res = self._rerank(query, [doc.page_content for doc in idxed_documents.values()])
            if self.score_threshold is not None:
                res = filter(lambda x: x["score"] >= self.score_threshold, res)

            for r in res:
                original_doc = idxed_documents[r["index"]]
                doc = Document(
                    page_content=original_doc.page_content,
                    metadata={"relevance_score": r["score"]} | original_doc.metadata,
                )
                responses.append(doc)
        return responses

    @override
    async def acompress_documents(
        self,
        documents: Sequence[Document],
        query: str,
        callbacks: Callbacks | None = None,  # noqa: ARG002
    ) -> Sequence[Document]:
        docs_chunks = self._split_documents(documents)
        responses = []
        for chunk in docs_chunks:
            idxed_documents = {i: doc for i, doc in enumerate(chunk) if doc.page_content}

            res = await self._arerank(query, [doc.page_content for doc in idxed_documents.values()])
            if self.score_threshold is not None:
                res = filter(lambda x: x["score"] >= self.score_threshold, res)

            for r in res:
                original_doc = idxed_documents[r["index"]]
                doc = Document(
                    page_content=original_doc.page_content,
                    metadata={"relevance_score": r["score"]} | original_doc.metadata,
                )
                responses.append(doc)
        return responses

    def _rerank(self, query: str, inputs: list[str]) -> list[RerankResponseEntry]:
        return requests.post(
            urljoin(self.base_url, "/rerank"),
            json={
                "query": query,
                "texts": inputs,
            },
            timeout=120,
        ).json()

    async def _arerank(self, query: str, inputs: list[str]) -> list[RerankResponseEntry]:
        """Asynchronous POST request."""
        async with (
            aiohttp.ClientSession() as session,
            session.post(
                urljoin(self.base_url, "/rerank"),
                json={
                    "query": query,
                    "texts": inputs,
                },
            ) as resp,
        ):
            return await resp.json()

    def _split_documents(self, docs: list[Document]) -> list[list[Document]]:
        """Split documents into chunks of size `self.batch_size`."""
        return [docs[i : i + self.batch_size] for i in range(0, len(docs), self.batch_size)]
