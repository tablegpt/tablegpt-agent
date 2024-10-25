import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

import numpy as np
import pandas as pd
from langchain_core.documents import Document
from langchain_core.messages import BaseMessage
from tablegpt.utils import (
    filter_content,
    format_columns,
    get_raw_table_info,
    list_sheets,
    path_from_uri,
)


class TestPathFromUri(unittest.TestCase):
    @unittest.skip("Cannot test linux path on windows and vice versa")
    def test_valid_file_uri_unix(self):
        """Test a valid 'file:' URI on a Unix system."""
        uri = "file:///home/user/file.txt"
        expected_path = Path("/home/user/file.txt")
        assert path_from_uri(uri) == expected_path

    @unittest.skip("Cannot test linux path on windows and vice versa")
    def test_valid_file_uri_windows(self):
        """Test a valid 'file:' URI on a Windows system."""
        uri = "file:///C:/Users/user/file.txt"
        expected_path = Path("C:/Users/user/file.txt")
        assert path_from_uri(uri) == expected_path

    @unittest.skip("Cannot test linux path on windows and vice versa")
    def test_valid_file_uri_unc_path(self):
        """Test a valid 'file:' URI with a UNC path."""
        uri = "file://localhost/Server/Share/file.txt"
        expected_path = Path("/Server/Share/file.txt")
        assert path_from_uri(uri) == expected_path

    def test_invalid_file_uri(self):
        """Test an invalid 'file:' URI that does not start with 'file:'."""
        uri = "http://example.com/file.txt"
        with self.assertRaises(ValueError) as cm:  # noqa: PT027
            path_from_uri(uri)
        assert str(cm.exception) == f"URI does not start with 'file:': '{uri}'"

    def test_relative_file_uri(self):
        """Test an invalid 'file:' URI that is not absolute."""
        uri = "file:relative/path/file.txt"
        with self.assertRaises(ValueError) as cm:  # noqa: PT027
            path_from_uri(uri)
        assert str(cm.exception) == f"URI is not absolute: '{uri}'"

    @unittest.skip("Cannot test linux path on windows and vice versa")
    def test_invalid_dos_drive(self):
        """Test an invalid 'file:' URI with incorrect DOS drive."""
        uri = "file://C|/path/to/file.txt"
        expected_path = Path("C:/path/to/file.txt")
        assert path_from_uri(uri) != expected_path

    @unittest.skip("Cannot test linux path on windows and vice versa")
    def test_valid_file_uri_with_encoded_characters(self):
        """Test a valid 'file:' URI with encoded characters."""
        uri = "file:///home/user/file%20name.txt"
        expected_path = Path("/home/user/file name.txt")
        assert path_from_uri(uri) == expected_path


class TestFormatColumns(unittest.TestCase):
    def test_format_empty_column_docs(self):
        formated_columns = format_columns([])
        assert formated_columns == ""

    def test_format_column_docs(self):
        docs = [
            Document(
                page_content="column:Sex",
                metadata={
                    "file_name": "foo.csv",
                    "column": "Sex",
                    "dtype": "string",
                    "n_unique": 2,
                    "values": ["male", "female"],
                },
            )
        ]
        formated_columns = format_columns(docs)
        hint = """
Here are some extra column information that might help you understand the dataset:
- foo.csv:
  - {"column": Sex, "dtype": "string", "values": ["male", "female"]}
"""
        assert formated_columns == hint

    def test_format_and_compress_column(self):
        docs = [
            Document(
                page_content="column:Sex",
                metadata={
                    "file_name": "foo.csv",
                    "column": "Sex",
                    "dtype": "string",
                    "n_unique": 3,
                    "values": ["male", "female", "unknown"],
                },
            )
        ]
        hint = """
Here are some extra column information that might help you understand the dataset:
- foo.csv:
  - {"column": Sex, "dtype": "string", "values": ["mal...", "fem...", ...]}
"""
        formated_columns = format_columns(docs, dataset_cell_length_threshold=3, max_dataset_cells=2)
        assert formated_columns == hint


class TestListSheets(unittest.TestCase):
    def setUp(self):
        self.mock_excel_file = MagicMock()
        # Patch pandas.ExcelFile to return the mock ExcelFile object
        patcher = patch("pandas.ExcelFile", return_value=self.mock_excel_file)
        self.mock_pd_excelfile = patcher.start()
        self.addCleanup(patcher.stop)  # Ensure patch is stopped after tests

    def test_list_sheets_with_sheets(self):
        """Test list sheets when Excel file contains sheets."""
        self.mock_excel_file.sheet_names = ["Sheet1", "Sheet2"]
        path = Path("/home/user/file.xlsx")
        sheet_names = list_sheets(path)
        assert sheet_names == ["Sheet1", "Sheet2"]


class TestGetRawTableInfo(unittest.TestCase):
    def test_unsupported_formats(self):
        """Test list sheets when Excel file contains sheets."""
        with self.assertRaises(ValueError) as e:  # noqa: PT027
            get_raw_table_info(Path("/home/user/file.text"))
            assert str(e) == "Unsupported file format: .text"

    @patch("tablegpt.utils.pd.ExcelFile")
    @patch("tablegpt.utils.read_df")
    def test_xlsx_with_sheetname(self, mock_read_df, mock_excel_file):
        mock_xls = MagicMock()
        mock_excel_file.return_value.__enter__.return_value = mock_xls  # Mock ExcelFile as a context manager
        mock_xls.sheet_names = ["Sheet1", "Sheet2"]  # Mock the sheet names in the file

        # Define side_effect for read_df based on sheet_name argument
        def mock_read_df_side_effect(filepath, **kwargs):  # noqa: ARG001
            return pd.DataFrame(
                [
                    ["Header1", "Header2", "Header3"],
                    ["Data1", 123, "MoreData1"],
                    ["Data2", 456, "MoreData2"],
                ]
            )

        mock_read_df.side_effect = mock_read_df_side_effect

        # First test for "Sheet1"
        raw_table_info_sheet1 = get_raw_table_info(filepath=Path("/home/user/file.xlsx"))

        # Expected output for Sheet1
        expected_df_info_sheet1 = [
            ["Header1", "Header2", "Header3"],
            ["Data1", 123, "MoreData1"],
            ["Data2", 456, "MoreData2"],
        ]

        # Assert Sheet1
        assert raw_table_info_sheet1 == expected_df_info_sheet1

    @patch("tablegpt.utils.pd.ExcelFile")
    @patch("tablegpt.utils.read_df")
    def test_xlsx_without_sheetname(self, mock_read_df, mock_excel_file):
        mock_xls = MagicMock()
        mock_excel_file.return_value.__enter__.return_value = mock_xls  # Mock ExcelFile as a context manager
        mock_xls.sheet_names = ["Sheet1", "Sheet2"]  # Mock the sheet names in the file

        # Define side_effect for read_df based on sheet_name argument
        def mock_read_df_side_effect(filepath, **kwargs):  # noqa: ARG001
            return pd.DataFrame(
                [
                    ["Header1", "Header2", "Header3"],
                    ["Data1", 123, "MoreData1"],
                    ["Data2", 456, "MoreData2"],
                ]
            )

        mock_read_df.side_effect = mock_read_df_side_effect

        # First test for "Sheet1"
        raw_table_info_sheet1 = get_raw_table_info(filepath=Path("/home/user/file.xls"))

        # Expected output for Sheet1
        expected_df_info_sheet1 = [
            ["Header1", "Header2", "Header3"],
            ["Data1", 123, "MoreData1"],
            ["Data2", 456, "MoreData2"],
        ]
        # Assert Sheet1
        assert raw_table_info_sheet1 == expected_df_info_sheet1

    @patch("tablegpt.utils.pd.ExcelFile")
    @patch("tablegpt.utils.read_df")
    def test_xls_with_sheetname(self, mock_read_df, mock_excel_file):
        mock_xls = MagicMock()
        mock_excel_file.return_value.__enter__.return_value = mock_xls  # Mock ExcelFile as a context manager
        mock_xls.sheet_names = ["Sheet1", "Sheet2"]  # Mock the sheet names in the file

        # Define side_effect for read_df based on sheet_name argument
        def mock_read_df_side_effect(filepath, **kwargs):  # noqa: ARG001
            return pd.DataFrame(
                [
                    ["Header1", "Header2", "Header3"],
                    ["Data1", 123, "MoreData1"],
                    ["Data2", 456, "MoreData2"],
                ]
            )

        mock_read_df.side_effect = mock_read_df_side_effect

        # First test for "Sheet1"
        raw_table_info_sheet1 = get_raw_table_info(filepath=Path("/home/user/file.xls"))

        # Expected output for Sheet1
        expected_df_info_sheet1 = [
            ["Header1", "Header2", "Header3"],
            ["Data1", 123, "MoreData1"],
            ["Data2", 456, "MoreData2"],
        ]

        # Assert Sheet1
        assert raw_table_info_sheet1 == expected_df_info_sheet1

    @patch("tablegpt.utils.pd.ExcelFile")
    @patch("tablegpt.utils.read_df")
    def test_xls_without_sheetname(self, mock_read_df, mock_excel_file):
        mock_xls = MagicMock()
        mock_excel_file.return_value.__enter__.return_value = mock_xls  # Mock ExcelFile as a context manager
        mock_xls.sheet_names = ["Sheet1", "Sheet2"]  # Mock the sheet names in the file

        # Define side_effect for read_df based on sheet_name argument
        def mock_read_df_side_effect(filepath, **kwargs):  # noqa: ARG001
            return pd.DataFrame(
                [
                    ["Header1", "Header2", "Header3"],
                    ["Data1", 123, "MoreData1"],
                    ["Data2", 456, "MoreData2"],
                ]
            )

        mock_read_df.side_effect = mock_read_df_side_effect

        # First test for "Sheet1"
        raw_table_info_sheet1 = get_raw_table_info(filepath=Path("/home/user/file.xls"))

        # Expected output for Sheet1
        expected_df_info_sheet1 = [
            ["Header1", "Header2", "Header3"],
            ["Data1", 123, "MoreData1"],
            ["Data2", 456, "MoreData2"],
        ]
        # Assert Sheet1
        assert raw_table_info_sheet1 == expected_df_info_sheet1

    @patch("tablegpt.utils.read_df")
    def test_csv(self, mock_read_df):
        # Set up the mock for csv.reader to return an iterator over the expected rows
        mock_read_df.return_value = pd.DataFrame(
            [
                ["Header1", "Header2", "Header3"],  # Header row
                ["Data1", "123", "MoreData1"],  # Data row 1
                ["Data2", "456", "MoreData2"],  # Data row 2
            ]
        )

        # Call the function with the mocked file
        raw_table_info = get_raw_table_info(filepath=Path("/home/user/file.csv"))

        expected_df_info = [
            ["Header1", "Header2", "Header3"],  # Header row
            ["Data1", "123", "MoreData1"],  # Row 1 data
            ["Data2", "456", "MoreData2"],  # Row 2 data
        ]
        # Assert that the function output matches the expected result
        assert raw_table_info == expected_df_info

    @patch("tablegpt.utils.read_df")
    def test_with_nan(self, mock_read_df):
        # Set up the mock for csv.reader to return an iterator over the expected rows
        mock_read_df.return_value = pd.DataFrame(
            {
                "str_col": [None, "Data1", "Data2"],
                "int_col": [123, 456, 789],
                "float_col": [1.1, np.nan, 3.3],
            }
        )

        # Call the function with the mocked file
        raw_table_info = get_raw_table_info(filepath=Path("/home/user/file.csv"))

        expected_df_info = [
            [None, 123, 1.1],
            ["Data1", 456, None],
            ["Data2", 789, 3.3],
        ]
        # Assert that the function output matches the expected result
        assert raw_table_info == expected_df_info

    @patch("tablegpt.utils.read_df")
    def test_with_timestamp(self, mock_read_df):
        # Set up the mock for csv.reader to return an iterator over the expected rows
        mock_read_df.return_value = pd.DataFrame(
            {
                "numbers": [1, 2, np.nan, 4],
                "dates": [
                    pd.Timestamp("2023-01-01 12:30"),
                    pd.NaT,
                    pd.Timestamp("2023-01-02"),
                    pd.NaT,
                ],
            }
        )

        # Call the function with the mocked file
        raw_table_info = get_raw_table_info(filepath=Path("/home/user/file.csv"))

        expected_df_info = [
            [1, "2023-01-01"],
            [2, None],
            [None, "2023-01-02"],
            [4, None],
        ]
        # Assert that the function output matches the expected result
        assert raw_table_info == expected_df_info


class TestFilterContent(unittest.TestCase):
    def test_filter_content_with_string_content(self):
        message = BaseMessage(content="Hello, World!", type="ai")
        result = filter_content(message)
        assert result.content == "Hello, World!"

    def test_filter_content_with_list_of_strings(self):
        message = BaseMessage(content=["Hello", "World"], type="ai")
        result = filter_content(message)
        assert result.content == ["Hello", "World"]

    def test_filter_content_with_list_of_dicts(self):
        message = BaseMessage(
            content=[
                {"type": "text", "text": "Hello"},
                {"type": "image_url", "image_url": "http://example.com/image.jpg"},
            ],
            type="ai",
        )
        result = filter_content(message)
        assert result.content == [{"type": "text", "text": "Hello"}]

    def test_filter_content_with_custom_keep(self):
        message = BaseMessage(
            content=[
                {"type": "text", "text": "Hello"},
                {"type": "image_url", "image_url": "http://example.com/image.jpg"},
            ],
            type="ai",
        )
        result = filter_content(message, keep=["image_url", "text"])
        assert result.content == [
            {"type": "text", "text": "Hello"},
            {"type": "image_url", "image_url": "http://example.com/image.jpg"},
        ]

    def test_filter_content_with_mixed_content(self):
        message = BaseMessage(
            content=[
                "Hello",
                {"type": "text", "text": "World"},
                {"type": "image_url", "image_url": "http://example.com/image.jpg"},
            ],
            type="ai",
        )
        result = filter_content(message)
        assert result.content == ["Hello", {"type": "text", "text": "World"}]

    def test_filter_content_with_no_text_type(self):
        message = BaseMessage(
            content=[
                {"type": "image_url", "image_url": "http://example.com/image.jpg"},
            ],
            type="ai",
        )
        result = filter_content(message)
        assert result.content == []


if __name__ == "__main__":
    unittest.main()
