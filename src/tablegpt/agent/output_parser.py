from __future__ import annotations

import logging
import re
from re import Pattern
from sys import version_info
from uuid import uuid4

from langchain.agents.agent import AgentOutputParser
from langchain_core.agents import AgentAction, AgentActionMessageLog, AgentFinish
from langchain_core.messages import AIMessage

from tablegpt.errors import SimpleOutputParserException

logger = logging.getLogger(__name__)

if version_info >= (3, 12):
    from typing import override
else:

    def override(func):
        return func


class MarkdownOutputParser(AgentOutputParser):
    """Output parser that extracts markdown code blocks and try to parse them into actions."""

    # group1: thought; group2: language; group3: tool_input; group4: remaining content
    pattern: Pattern = re.compile(r"([\S\s]*?)`{3}([\w]*)\n([\S\s]+?)\n`{3}([\S\s]*)", re.DOTALL)
    language_actions: dict[str, str] = {}  # noqa: RUF012
    """A mapping from language to action key."""
    just_finish: bool = True
    """Whether to just return AgentFinish if no parser can parse the output. Default to True."""

    @override
    def parse(self, text: str) -> AgentAction | AgentFinish:
        if (match := re.search(self.pattern, text)) is not None:
            thought = match.group(1).strip()
            language = match.group(2)
            tool_input = match.group(3).strip()
            if (action := self.language_actions.get(language)) is not None:
                return AgentActionMessageLog(
                    tool=action,
                    tool_input=tool_input,
                    # log is the 'thought' part
                    log=thought,
                    # message_log is the content we can add to history
                    # polishing the content will improve the following iterations
                    # TODO: run id
                    message_log=[
                        AIMessage(
                            id=str(uuid4()),
                            # We preserve only the 'thought' and the 'action' part, and remove the 'remaining content' part
                            content=text.removesuffix(match.group(4)).strip(),
                            tool_calls=[
                                {
                                    "name": action,
                                    "args": {"query": tool_input},
                                    "id": str(uuid4()),
                                }
                            ],
                            # deprecate the "action" part in additional_kwargs?
                            additional_kwargs={
                                "thought": thought,
                                "action": {
                                    "tool": action,
                                    "tool_input": tool_input,
                                },
                            },
                        )
                    ],
                )
            logger.warning("Unknown language %s", language)
        if self.just_finish:
            return AgentFinish({"output": text}, text)
        raise SimpleOutputParserException(text)

    @override
    @property
    def _type(self) -> str:
        return "markdown"
