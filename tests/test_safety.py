import unittest

from tablegpt.safety import HazardOutputParser


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

    def test_parse_unsafe_text_with_category(self):
        text = "unsafe\nS1"
        result = self.parser.parse(text)
        assert result == ("unsafe", "S1")

    def test_parse_unsafe_text_with_invalid_format(self):
        text = "unsafe only one line"
        result = self.parser.parse(text)
        assert result == ("unknown", None)


if __name__ == "__main__":
    unittest.main()
