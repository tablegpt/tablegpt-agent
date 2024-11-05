from __future__ import annotations

import asyncio
import itertools
from sys import version_info
from urllib.parse import urljoin

import aiohttp
import requests
from langchain_core.embeddings import Embeddings
from pydantic import BaseModel

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


class HuggingfaceTEIEmbeddings(BaseModel, Embeddings):
    """See <https://huggingface.github.io/text-embeddings-inference/>"""

    base_url: str
    normalize: bool = True
    truncate: bool = False
    query_instruction: str = ""
    """Instruction to use for embedding query."""
    batch_size: int = 32
    """client batch size. text-embedding-inference defaults to 32."""

    @override
    def embed_documents(self, texts: list[str]) -> list[list[float]]:
        texts_chunks = self._split_texts(texts)
        responses = []
        for chunk in texts_chunks:
            responses += self._embed(chunk)
        return responses

    @override
    async def aembed_documents(self, texts: list[str]) -> list[list[float]]:
        """Asynchronous Embed search docs."""
        texts_chunks = self._split_texts(texts)
        tasks = [self._aembed(inputs=chunk) for chunk in texts_chunks]

        res = await asyncio.gather(*tasks)
        return list(itertools.chain.from_iterable(res))

    @override
    def embed_query(self, text: str) -> list[float]:
        instructed_query = self.query_instruction + text
        return self.embed_documents([instructed_query])[0]

    @override
    async def aembed_query(self, text: str) -> list[float]:
        instructed_query = self.query_instruction + text
        embeddings = await self.aembed_documents([instructed_query])
        return embeddings[0]

    def _embed(self, inputs: list[str]) -> list[float]:
        return requests.post(
            urljoin(self.base_url, "/embed"),
            json={
                "inputs": inputs,
                "normalize": self.normalize,
                "truncate": self.truncate,
            },
            timeout=120,
        ).json()

    async def _aembed(self, inputs: list[str]) -> list[float]:
        """Asynchronous POST request."""
        async with (
            aiohttp.ClientSession() as session,
            session.post(
                urljoin(self.base_url, "/embed"),
                json={
                    "inputs": inputs,
                    "normalize": self.normalize,
                    "truncate": self.truncate,
                },
            ) as resp,
        ):
            return await resp.json()

    def _split_texts(self, texts: list[str]) -> list[list[str]]:
        """Split texts into chunks of size `self.batch_size`."""
        return [texts[i : i + self.batch_size] for i in range(0, len(texts), self.batch_size)]
