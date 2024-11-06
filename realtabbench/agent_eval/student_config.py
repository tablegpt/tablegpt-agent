from __future__ import annotations

import tempfile
from typing import Any

from pydantic import BaseModel, DirectoryPath
from pydantic_settings import BaseSettings, SettingsConfigDict


class IpythonSettings(BaseModel):
    incluster: bool = False
    """Use kubernetes crd create kernel. if `incluster==true` load incluster config and create kerne CR as remote kernel"""
    env_file: str | None = None
    """Path to the environment file to use for the kernel."""


# TODO: this is also somehow a copy-paste from tablegpt-chat, with slight modifications
# Maybe we need to refactor that too?
class Settings(BaseSettings):
    """Application runtime settings.

    We give almost everything a default value, to make unittest easier.
    """

    model_config = SettingsConfigDict(env_nested_delimiter="__", extra="ignore")

    llm: dict[str, Any] = {}
    vlm: dict[str, Any] | None = None
    guard_llm: dict[str, Any] | None = None
    normalize_llm: dict[str, Any] | None = None
    """LLM used to normalize unstructured dataset"""

    data_vol: DirectoryPath = tempfile.gettempdir()
    """Data volume used to persist query results"""
    ipython_kernel: IpythonSettings = IpythonSettings()
    """Kubernetes Kernel Client settings"""
    error_trace_cleanup: bool = False
    """Enable trace cleanup to remove unnecessary error messages.
    This feature prunes the error trace to reduce the context length sent to the LLM, helping weaker models focus on the specific error line.
    When enabled, only a small context around the exact error line, along with a brief error description, is retained.
    While this is considered experimental, and some performance improvements have been observed, it may lead to information loss in certain situations.
    """
