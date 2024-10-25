import logging
import unittest
from unittest.mock import patch
from uuid import uuid4

from langchain_core.agents import AgentActionMessageLog, AgentFinish
from langchain_core.exceptions import OutputParserException
from langchain_core.messages import AIMessage
from tablegpt.agent.output_parser import MarkdownOutputParser

logger = logging.getLogger(__name__)


class TestMarkdownOutputParser(unittest.TestCase):
    @patch("tablegpt.agent.output_parser.uuid4")
    def test_valid_markdown_known_language_action(self, mock_uuid):
        fixed_uuid = uuid4()
        mock_uuid.return_value = fixed_uuid
        text = "Some text\n```python\nprint('Hello, World!')\n```More text"
        parser = MarkdownOutputParser(language_actions={"python": "python"})
        expected_action = AgentActionMessageLog(
            tool="python",
            tool_input="print('Hello, World!')",
            log="Some text",
            message_log=[
                AIMessage(
                    id=str(fixed_uuid),
                    content="Some text\n```python\nprint('Hello, World!')\n```",
                    tool_calls=[
                        {
                            "name": "python",
                            "args": {"query": "print('Hello, World!')"},
                            "id": str(fixed_uuid),
                        }
                    ],
                    additional_kwargs={
                        "thought": "Some text",
                        "action": {
                            "tool": "python",
                            "tool_input": "print('Hello, World!')",
                        },
                    },
                )
            ],
        )
        result = parser.parse(text)
        assert result == expected_action

    def test_valid_markdown_unknown_language(self):
        text = "Some text\n```unknown\nprint('Hello, World!')\n```More text"
        parser = MarkdownOutputParser()
        with self.assertLogs("tablegpt.agent.output_parser", level="WARNING") as log:
            result = parser.parse(text)
            assert "Unknown language" in log.output[0]
        assert result == AgentFinish({"output": text}, text)

    def test_valid_markdown_no_code_block(self):
        text = "Some text\nWithout code block"
        parser = MarkdownOutputParser(just_finish=False)
        with self.assertRaises(OutputParserException):  # noqa: PT027
            result = parser.parse(text)
        # TODO: we can mock this behaviour instead of creating a new one
        parser = MarkdownOutputParser()
        result = parser.parse(text)
        assert result == AgentFinish({"output": text}, text)

    @unittest.skip("This test is failing because the parser is not able to parse multiple code blocks")
    def test_valid_markdown_multiple_code_blocks(self):
        fixed_uuid = uuid4()
        text = "Some text\n```python\nprint('Hello, World!')\n```More text\n```java\nSystem.out.println('Hello, World!')\n```"
        parser = MarkdownOutputParser(language_actions={"python": "python", "java": "java"})
        expected_action = AgentActionMessageLog(
            tool="python",
            tool_input="print('Hello, World!')",
            log="Some text",
            message_log=[
                AIMessage(
                    id=str(fixed_uuid),
                    content="Some text\n```python\nprint('Hello, World!')\n```",
                    tool_calls=[
                        {
                            "name": "python",
                            "args": {"query": "print('Hello, World!')"},
                            "id": str(fixed_uuid),
                        },
                        {
                            "name": "python",
                            "args": {"query": "System.out.println('Hello, World!')"},
                            "id": str(fixed_uuid),
                        },
                    ],
                    additional_kwargs={
                        "thought": "More text",
                        "action": {
                            "tool": "java",
                            "tool_input": "print('Hello, World!')",
                        },
                    },
                )
            ],
        )
        result = parser.parse(text)
        assert result == expected_action

    def test_empty_input(self):
        text = ""
        parser = MarkdownOutputParser(just_finish=False)
        with self.assertRaises(OutputParserException):  # noqa: PT027
            result = parser.parse(text)
        # TODO: we can mock this behaviour instead of creating a new one
        parser = MarkdownOutputParser()
        result = parser.parse(text)
        assert result == AgentFinish({"output": text}, text)


if __name__ == "__main__":
    unittest.main()
