from __future__ import annotations

import mimetypes
import re
from re import Pattern
from sys import version_info
from typing import TYPE_CHECKING, Literal

from langchain_core.callbacks.manager import CallbackManagerForToolRun  # noqa: TCH002
from langchain_core.tools import BaseTool
from pybox.base import BasePyBoxManager  # noqa: TCH002
from pydantic import BaseModel, DirectoryPath, field_validator, model_validator
from typing_extensions import Self

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


if TYPE_CHECKING:
    from pathlib import Path

    from pybox.schema import ErrorContent, PyBoxOut


class Artifact(BaseModel):
    """Agent created files"""

    filename: str | None = None
    path: Path
    """Absolute path to the artifact. I kept this field for tracing purposes."""
    mimetype: str | None = None
    """An optional mimetype for the artifact.
    OS is not guaranteed to guess the mimetype of any file."""

    @model_validator(mode="after")
    def extract_filename(self) -> Self:
        self.filename = self.path.name
        return self

    @field_validator("path")
    @classmethod
    def ensure_path_absolute(cls, v: Path) -> Path:
        return v.absolute()


class IPythonTool(BaseTool):
    name: str = "python"
    description: str = "IPython kernel tool"
    response_format: Literal["content_and_artifact"] = "content_and_artifact"
    pybox_manager: BasePyBoxManager
    cwd: DirectoryPath | None = None
    session_id: str | None = None
    filesaving_pattern: Pattern = re.compile(r'(?:\.savefig|\.to_csv)\(\s*[\'"]([^\'"]+)[\'"]\s*')
    error_trace_cleanup: bool = False
    error_trace_cleanup_pattern: Pattern = re.compile(r"(Cell In\[\d+\], line \d+\n(?:.*\n)*?)(?=\n)")

    @override
    def _run(
        self,
        query: str,
        run_manager: CallbackManagerForToolRun | None = None,  # noqa: ARG002
    ) -> tuple[list[str | dict], list[Artifact]]:
        kwargs = {"cwd": str(self.cwd)} if self.cwd is not None else {}
        box = self.pybox_manager.start(kernel_id=self.session_id, **kwargs)

        try:
            res: PyBoxOut = box.run(code=query)
        except TimeoutError:
            return "Execution timed out. Please try again.", []

        content = []
        artifact = []

        for part in res.data:
            # We cannot mix str with dict for now, as `langgraph.prebuilt.ToolNode.msg_content_output` will dump it to str otherwise.
            # So we need to specify the text parts as dict.
            if (text_part := part.get("text/plain")) is not None:
                content.append({"type": "text", "text": text_part})

            if (img_part := part.get("image/png")) is not None:
                content.append(
                    {
                        "type": "image_url",
                        "image_url": {"url": f"data:image/png;base64,{img_part}"},
                    }
                )

        for path in self._guess_artifact_paths(query):
            mimetype, _ = mimetypes.guess_type(path)
            artifact.append(Artifact(path=path, mimetype=mimetype))

        if res.error is not None:
            cleaned_error = self._extract_error_trace(res.error)
            content.append({"type": "text", "text": cleaned_error})

        return content, artifact

    @override
    async def _arun(
        self,
        query: str,
        run_manager: CallbackManagerForToolRun | None = None,  # noqa: ARG002
    ) -> tuple[list[str | dict], list[Artifact]]:
        kwargs = {"cwd": str(self.cwd)} if self.cwd is not None else {}
        box = await self.pybox_manager.astart(kernel_id=self.session_id, **kwargs)

        try:
            res: PyBoxOut = await box.arun(code=query)
        except TimeoutError:
            return "Execution timed out. Please try again.", []

        content = []
        artifact = []

        for part in res.data:
            # We cannot mix str with dict for now, as `langgraph.prebuilt.ToolNode.msg_content_output` will dump it to str otherwise.
            # So we need to specify the text parts as dict.
            if (text_part := part.get("text/plain")) is not None:
                content.append({"type": "text", "text": text_part})

            if (img_part := part.get("image/png")) is not None:
                content.append(
                    {
                        "type": "image_url",
                        "image_url": {"url": f"data:image/png;base64,{img_part}"},
                    }
                )

        for path in self._guess_artifact_paths(query):
            mimetype, _ = mimetypes.guess_type(path)
            artifact.append(Artifact(path=path, mimetype=mimetype))

        if res.error is not None:
            cleaned_error = self._extract_error_trace(res.error)
            content.append({"type": "text", "text": cleaned_error})

        return content, artifact

    def _guess_artifact_paths(self, code: str) -> list[Path]:
        """Guess artifact paths from code.

        Args:
            code (str): Code that got executed by the tool.

        Returns:
            list[Path]: A list of existing artifact paths.
        """
        # Use a set to deduplicate artifacts by filenames.
        filenames = set(re.findall(self.filesaving_pattern, code))
        paths = [self.cwd.joinpath(filename) for filename in filenames]
        return [path for path in paths if path.exists()]

    def _extract_error_trace(self, e: ErrorContent) -> str:
        if self.error_trace_cleanup and (match := re.search(self.error_trace_cleanup_pattern, str(e))) is not None:
            first_part = match.group(0)
            return f"{first_part}\n{e.ename}: {e.evalue}\n"
        return str(e)


# We cannot merge and format the std output inside the tool, as we need the number of content parts to determine the encoder input.
# Which should be refactored in the future.
# So for now we provide a helper function to merge the text parts and a template to format the std output.


def process_content(content: str | list[str | dict]) -> list[dict]:
    """Merge text parts in the content list.

    As `langgraph.prebuilt.ToolNode` will dump the content list to str if it contains mixed str and dict,
    this function also ensures all text parts are in the form of dict with "type": "text".
    """

    text_parts = []
    other_parts = []

    if isinstance(content, str):
        text_parts.append(content)
    elif isinstance(content, list):
        for part in content:
            if isinstance(part, str):
                # Append string part to text_parts
                text_parts.append(part)
            elif isinstance(part, dict) and part.get("type") == "text":
                # Append text from dict part with "type": "text"
                text_parts.append(part["text"])
            else:
                # Keep other dict part unchanged
                other_parts.append(part)

    # Create the merged "type": "text" part if there is any text to merge
    if text_parts:
        merged_element = {"type": "text", "text": "\n".join(text_parts)}
        return [merged_element, *other_parts]

    return other_parts


markdown_console_template = """```pycon
{res}
```"""
