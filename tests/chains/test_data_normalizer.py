import unittest

from langchain_core.exceptions import OutputParserException
from tablegpt.chains.data_normalizer import (
    CodeOutputParser,
    ListListOutputParser,
    ListTupleOutputParser,
    wrap_normalize_code,
)


class TestListListOutputParser(unittest.TestCase):
    def setUp(self):
        self.parser = ListListOutputParser()

    def test_parse_within_text(self):
        """Test parsing of a valid list structure embedded within additional text."""
        result = self.parser.parse('some prefix [["col1","col2"]], some suffix.')
        assert result == [["col1", "col2"]]

    def test_parse_single_inner_list(self):
        """Test parsing of a single inner list structure."""
        result = self.parser.parse('[["col1","col2"]]')
        assert result == [["col1", "col2"]]

    def test_parse_multiple_inner_lists(self):
        """Test parsing of multiple inner list structures."""
        result = self.parser.parse('[["col1","col2", ""], ["row1", "row2", ""]]')
        assert result == [["col1", "col2", ""], ["row1", "row2", ""]]

    def test_parse_inner_lists_with_brackets(self):
        """Test parsing of inner lists that contain string items with brackets."""
        result = self.parser.parse('[["[col1", "]col2"], ["r[]ow1", "[row2]"]]')
        assert result == [["[col1", "]col2"], ["r[]ow1", "[row2]"]]

    def test_parse_list_with_empty_inner_list(self):
        """Test parsing of a list that includes an empty inner list."""
        result = self.parser.parse('[["col1","col2"], [], ["row1", "row2"]]')
        assert result == [["col1", "col2"], [], ["row1", "row2"]]

    def test_parse_inner_list_with_single_element(self):
        """Test parsing of inner lists containing a single element."""
        result = self.parser.parse('[["col1",], ["row1",]]')
        assert result == [["col1"], ["row1"]]

    def test_parse_whitespaces(self):
        """Test parsing of inner lists that include extraneous whitespace."""
        result = self.parser.parse(' [["col1","col2"], ["row1", "row2"], [ "col3" , "col4" ]] ')
        assert result == [["col1", "col2"], ["row1", "row2"], ["col3", "col4"]]

    def test_parse_inner_list_with_commas(self):
        """Test parsing of inner lists containing items with commas."""
        result = self.parser.parse('[[",col1", "co,l2"], ["row1,", "r,o,w2"]]')
        assert result == [[",col1", "co,l2"], ["row1,", "r,o,w2"]]

    def test_parse_outer_empty_list(self):
        """Test parsing of an outer empty list."""
        result = self.parser.parse("[]")
        assert result == []

    def test_parse_inner_empty_lists(self):
        """Test parsing of inner lists that are empty."""
        assert self.parser.parse("[[]]") == [[]]
        assert self.parser.parse("[[],[]]") == [[], []]

    def test_parse_inner_lists_with_mixed_item_types(self):
        """Test parsing of inner lists containing mixed item types."""
        result = self.parser.parse('[[1, "string", 3.14, True, None], [2, "another", 0.9, False, None]]')
        assert result == [
            [1, "string", 3.14, True, None],
            [2, "another", 0.9, False, None],
        ]

    def test_parse_mixed_types(self):
        """Test parsing of a structure with mixed types that should raise an exception."""
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse('[[1, 2], "string", [3, 4]]')

    def test_parse_inner_lists_with_special_characters(self):
        """Test parsing of inner lists containing strings with special characters."""
        result = self.parser.parse(
            '[["!@#$%^&*()_+", "{}"], ["e\'f", "g/"], ["\\\\a"], ["(ab)", "[cd]"], ["[abc]", "[def]"], ["{abc}", "{def}"], ["<c>", "|d|"], ["(abc)", "(def)"]]'
        )
        assert result == [
            ["!@#$%^&*()_+", "{}"],
            ["e'f", "g/"],
            ["\\a"],
            ["(ab)", "[cd]"],
            ["[abc]", "[def]"],
            ["{abc}", "{def}"],
            ["<c>", "|d|"],
            ["(abc)", "(def)"],
        ]

    def test_one_dimension_array(self):
        """Test parsing of a one-dimensional array that should raise an exception."""
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[1,2,3]")

    def test_invalid_output(self):
        """Test parsing of various invalid outputs that should raise exceptions."""
        # incomplete 2d array
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1,2], [3,")

        # partial 2d array
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1,2], 3, [4, 5]]")

        # partial 2d array
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1,2], [4, 5], 3]")

        # missing comma
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1, 2] [4, 5]]")

        # invalid list structure
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1, 2), (4, 5]]")

        # Extra commas
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1,2],, [3,4]]")

        # Improperly formatted inner lists
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1 2],, [3,4]]")

    def test_parse_unrecognized(self):
        """Test parsing of unrecognized output that should raise an exception."""
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("unrecognized input")


class TestListTupleOutputParser(unittest.TestCase):
    def setUp(self):
        self.parser = ListTupleOutputParser()

    def test_parse_within_text(self):
        """Test parsing of a valid tuple structure embedded within additional text."""
        result = self.parser.parse('some prefix [("col1","col2")], some suffix.')
        assert result == [["col1", "col2"]]

    def test_parse_single_inner_tuple_list(self):
        """Test parsing of a single inner tuple."""
        result = self.parser.parse('[("col1","col2")]')
        assert result == [["col1", "col2"]]

    def test_parse_multiple_inner_tuple_lists(self):
        """Test parsing of multiple inner tuples."""
        result = self.parser.parse('[("col1","col2", ""), ("row1", "row2", "")]')
        assert result == [["col1", "col2", ""], ["row1", "row2", ""]]

    def test_parse_inner_tuple_with_parentheses(self):
        """Test parsing of inner tuples that contain string items with parentheses."""
        result = self.parser.parse('[("(col1", ")col2"), ("r()ow1", "(row2)")]')
        assert result == [["(col1", ")col2"], ["r()ow1", "(row2)"]]

    def test_parse_list_with_empty_tuple(self):
        """Test parsing of a list that includes an empty tuple as an inner element."""
        result = self.parser.parse('[("col1","col2"), (), ("row1", "row2")]')
        assert result == [["col1", "col2"], [], ["row1", "row2"]]

    def test_parse_single_element_tuple(self):
        """Test parsing of a list containing single-element tuples."""
        result = self.parser.parse('[("col1",), ("row1",)]')
        assert result == [["col1"], ["row1"]]

    def test_parse_whitespaces(self):
        """Test parsing of inner tuples that include extraneous whitespace."""
        result = self.parser.parse(' [("col1","col2"), ("row1", "row2"),  ( "col3" , "col4" )] ')
        assert result == [["col1", "col2"], ["row1", "row2"], ["col3", "col4"]]

    def test_parse_inner_tuple_with_commas(self):
        """Test parsing of inner tuples containing items with commas."""
        result = self.parser.parse('[(",col1","co,l2"), ("row1,", "r,o,w2")]')
        assert result == [[",col1", "co,l2"], ["row1,", "r,o,w2"]]

    def test_parse_outer_empty_list(self):
        """Test parsing of an outer empty list."""
        result = self.parser.parse("[]")
        assert result == []

    def test_parse_inner_empty_tuples(self):
        """Test parsing of inner tuples that are empty."""
        assert self.parser.parse("[(),()]") == [[], []]
        assert self.parser.parse("[()]") == [[]]

    def test_parse_inner_tuples_with_mixed_item_types(self):
        """Test parsing of inner tuples containing mixed item types."""
        result = self.parser.parse('[(1, "string", 3.14, True, None), (2, "another", 0.9, False, None)]')
        assert result == [
            [1, "string", 3.14, True, None],
            [2, "another", 0.9, False, None],
        ]

    def test_parse_mixed_types(self):
        """Test parsing of a structure with mixed types that should raise an exception."""
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse('[(1, 2), "string", (3, 4)]')

    def test_parse_inner_tuples_with_special_characters(self):
        """Test parsing of inner tuples containing strings with special characters."""
        result = self.parser.parse(
            '[("!@#$%^&*()_+", "{}"), ("e\'f", "g/"), ("\\\\a",), ("[abc]", "[def]"), ("{abc}", "{def}"), ("<c>", "|d|"), ("(abc)", "(def)")]'
        )
        assert result == [
            ["!@#$%^&*()_+", "{}"],
            ["e'f", "g/"],
            ["\\a"],
            ["[abc]", "[def]"],
            ["{abc}", "{def}"],
            ["<c>", "|d|"],
            ["(abc)", "(def)"],
        ]

    def test_one_dimension_array(self):
        """Test parsing of a one-dimensional array that should raise an exception."""
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[1,2,3]")

    def test_invalid_output(self):
        """Test parsing of various invalid outputs that should raise exceptions."""
        # incomplete tuple
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[(1,2), (3,")

        # incomplete tuple
        with self.assertRaises(OutputParserException):  # noqa: PT027s
            self.parser.parse("[(,)]")

        # partial tuple
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[(1,2), 3, (4, 5)]")

        # partial tuple
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[(1,2), (4, 5), 3]")

        # tuple without comma
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[(1, 2) (4, 5)]")

        # invalid tuple structure
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[[1, 2), (4, 5]]")

        # Extra commas
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[(1,2),, (3,4)]")

        # Improperly formatted inner tuple
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("[(1 2),, (3,4)]")

    def test_parse_unrecognized(self):
        """Test parsing of unrecognized output that should raise an exception."""
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("unrecognized input")


class TestCodeOutputParser(unittest.TestCase):
    def setUp(self):
        self.parser = CodeOutputParser()

    def test_parse_valid_python(self):
        result = self.parser.parse(
            """```python
final_df = blah```
"""
        )
        assert result == "final_df = blah" + self.parser.suffix

    def test_parse_valid_python_without_newline(self):
        result = self.parser.parse(
            """```python
final_df = blah
```"""
        )
        assert result == "final_df = blah" + self.parser.suffix

    def test_parse_unknown(self):
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse("""print("hi")""")

    def test_parse_no_final_df(self):
        with self.assertRaises(OutputParserException):  # noqa: PT027
            self.parser.parse(
                """```python
print("hello")
```"""
            )


class TestWrapNormalizeCode(unittest.TestCase):
    def test_wrap_normalize_code_basic(self):
        var_name = "data_frame"
        normalization_code = "final_df = df.dropna()"
        expected_output = """\
# Normalize the data
try:
    df = data_frame.copy()

    final_df = df.dropna()
    # reassign data_frame with the formatted DataFrame
    data_frame = final_df
except Exception as e:
    # Unable to apply formatting to the original DataFrame. proceeding with the unformatted DataFrame.
    print(f"Reformat failed with error {e}, use the original DataFrame.")"""

        assert wrap_normalize_code(var_name, normalization_code).strip() == expected_output.strip()

    def test_wrap_empty_normalize_code(self):
        var_name = "data_frame"
        normalization_code = ""
        expected_output = """\
# Normalize the data
try:
    df = data_frame.copy()


    # reassign data_frame with the formatted DataFrame
    data_frame = final_df
except Exception as e:
    # Unable to apply formatting to the original DataFrame. proceeding with the unformatted DataFrame.
    print(f"Reformat failed with error {e}, use the original DataFrame.")"""

        assert wrap_normalize_code(var_name, normalization_code).strip() == expected_output.strip()

    def test_wrap_multi_line_normalize_code(self):
        var_name = "my_data_frame"
        normalization_code = "foo = 1\nbar = 2"
        expected_output = """\
# Normalize the data
try:
    df = my_data_frame.copy()

    foo = 1
    bar = 2
    # reassign my_data_frame with the formatted DataFrame
    my_data_frame = final_df
except Exception as e:
    # Unable to apply formatting to the original DataFrame. proceeding with the unformatted DataFrame.
    print(f"Reformat failed with error {e}, use the original DataFrame.")"""

        assert wrap_normalize_code(var_name, normalization_code).strip() == expected_output.strip()


if __name__ == "__main__":
    unittest.main()
