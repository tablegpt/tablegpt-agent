from __future__ import annotations

import logging
from sys import version_info
from typing import TYPE_CHECKING, Any

from langchain_qdrant import Qdrant

logger = logging.getLogger(__name__)

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


if TYPE_CHECKING:
    from collections.abc import Iterable, Sequence


class FallbackQdrant(Qdrant):
    """Because the vector database does not have acid, I need to manually roll back this request.
    Maybe should be added to `langchain_core.vectorstores.VectorStore`."""

    @override
    def add_texts(
        self,
        texts: Iterable[str],
        metadatas: list[dict] | None = None,
        ids: Sequence[str] | None = None,
        batch_size: int = 64,
        **kwargs: Any,
    ) -> list[str]:
        added_ids = []
        fallback = kwargs.pop("fallback", False)
        for batch_ids, points in self._generate_rest_batches(texts, metadatas, ids, batch_size):
            try:
                self.client.upsert(collection_name=self.collection_name, points=points, **kwargs)
                added_ids.extend(batch_ids)
            except Exception:
                if fallback:
                    logger.warning("Embedding vector failed and data needs to be rolled back.")
                    self.delete(ids=added_ids)
                    self.delete(ids=batch_ids)
                raise

        return added_ids

    @override
    async def aadd_texts(
        self,
        texts: Iterable[str],
        metadatas: list[dict] | None = None,
        ids: Sequence[str] | None = None,
        batch_size: int = 64,
        **kwargs: Any,
    ) -> list[str]:
        from qdrant_client.local.async_qdrant_local import AsyncQdrantLocal

        if self.async_client is None or isinstance(
            self.async_client._client,  # noqa: SLF001
            AsyncQdrantLocal,
        ):
            # See [EM101](https://docs.astral.sh/ruff/rules/raw-string-in-exception/)
            msg = "QdrantLocal cannot interoperate with sync and async clients"
            raise NotImplementedError(msg)
        fallback = kwargs.pop("fallback", False)
        added_ids = []
        async for batch_ids, points in self._agenerate_rest_batches(texts, metadatas, ids, batch_size):
            try:
                await self.async_client.upsert(collection_name=self.collection_name, points=points, **kwargs)
                added_ids.extend(batch_ids)
            except Exception:
                if fallback:
                    logger.warning("Embedding vector failed and data needs to be rolled back.")
                    await self.adelete(ids=added_ids)
                    await self.adelete(ids=batch_ids)
                raise

        return added_ids

    @override
    def delete(self, ids: list[str] | None = None, **kwargs: Any) -> bool | None:
        """Delete by vector ID or other criteria.

        Args:
            ids: List of ids to delete. If None, check kwargs for points_selector.
            **kwargs: Other keyword arguments that subclasses might use. If ids is None,
                this should contain points_selector.

        Returns:
            True if deletion is successful, False otherwise.
        """
        from qdrant_client.http import models as rest

        # Check if ids is None and points_selector exists in kwargs
        points_selector = kwargs["points_selector"] if ids is None and "points_selector" in kwargs else ids

        result = self.client.delete(
            collection_name=self.collection_name,
            points_selector=points_selector,
        )
        return result.status == rest.UpdateStatus.COMPLETED

    @override
    async def adelete(self, ids: list[str] | None = None, **kwargs: Any) -> bool | None:
        """Delete by vector ID or other criteria.

        Args:
            ids: List of ids to delete. If None, check kwargs for points_selector.
            **kwargs: Other keyword arguments that subclasses might use. If ids is None,
                this should contain points_selector.

        Returns:
            True if deletion is successful, False otherwise.
        """
        from qdrant_client.local.async_qdrant_local import AsyncQdrantLocal

        if self.async_client is None or isinstance(
            self.async_client._client,  # noqa: SLF001
            AsyncQdrantLocal,
        ):
            # See [EM101](https://docs.astral.sh/ruff/rules/raw-string-in-exception/)
            msg = "QdrantLocal cannot interoperate with sync and async clients"
            raise NotImplementedError(msg)

        from qdrant_client.http import models as rest

        # Check if ids is None and points_selector exists in kwargs
        points_selector = kwargs["points_selector"] if ids is None and "points_selector" in kwargs else ids

        result = await self.async_client.delete(
            collection_name=self.collection_name,
            points_selector=points_selector,
        )

        return result.status == rest.UpdateStatus.COMPLETED
