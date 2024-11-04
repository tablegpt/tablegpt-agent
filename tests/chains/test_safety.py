import unittest
from unittest import mock

from tablegpt.chains.safety import HazardOutputParser


class TestHazardOutputParser(unittest.TestCase):
    def setUp(self):
        self.parser = HazardOutputParser()

    def test_parse_safe(self):
        result = self.parser.parse("\n\nsafe")
        assert result == ("safe", None)

    def test_parse_safe_with_spaces(self):
        result = self.parser.parse("\n\n safe ")
        assert result == ("safe", None)

    def test_parse_unknown(self):
        result = self.parser.parse("unrecognized input")
        assert result == ("unknown", None)

    @mock.patch(
        "tablegpt.chains.safety.hazard_categories",
        {
            "hazard1": "category1",
        },
    )
    def test_parse_unsafe_with_known_category(self):
        result = self.parser.parse("\n\nunsafe\nhazard1")
        assert result == ("unsafe", "category1")

    @mock.patch(
        "tablegpt.chains.safety.hazard_categories",
        {
            "hazard1": "category1",
        },
    )
    def test_parse_unsafe_with_known_category_spaces(self):
        result = self.parser.parse("\n\n unsafe\nhazard1 ")
        assert result == ("unsafe", "category1")

    def test_parse_unsafe_with_unknown_category(self):
        result = self.parser.parse("\n\nunsafe\nunknown_hazard")
        assert result == ("unsafe", None)

    def test_parse_malformed_input(self):
        result = self.parser.parse("unsafe")
        assert result == ("unknown", None)


if __name__ == "__main__":
    unittest.main()
