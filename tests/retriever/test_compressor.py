import unittest

from langchain_core.documents import Document
from tablegpt.retriever.compressor import ColumnDocCompressor


class TestCompressDocuments(unittest.TestCase):
    def setUp(self):
        self.processor = ColumnDocCompressor()

    def test_single_column_single_file(self):
        documents = [
            Document(
                page_content="cell content",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "value": 1},
            ),
            Document(
                page_content="cell content",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "value": 2},
            ),
        ]

        expected_output = [
            Document(
                page_content="column: A",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "values": [1, 2]},
            )
        ]

        result = self.processor.compress_documents(documents, query="")
        assert result == expected_output

    def test_multiple_columns_single_file(self):
        documents = [
            Document(
                page_content="A:1",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "value": 1},
            ),
            Document(
                page_content="B:hello",
                metadata={"file_name": "file1", "column": "B", "dtype": "str", "n_unique": 3, "value": "hello"},
            ),
        ]

        expected_output = [
            Document(
                page_content="column: A",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "values": [1]},
            ),
            Document(
                page_content="column: B",
                metadata={"file_name": "file1", "column": "B", "dtype": "str", "n_unique": 3, "values": ["hello"]},
            ),
        ]

        result = self.processor.compress_documents(documents, query="")
        assert result == expected_output

    def test_multiple_columns_multiple_files(self):
        documents = [
            Document(
                page_content="cell content",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "value": 1},
            ),
            Document(
                page_content="cell content",
                metadata={"file_name": "file2", "column": "A", "dtype": "int", "n_unique": 4, "value": 2},
            ),
            Document(
                page_content="cell content",
                metadata={"file_name": "file2", "column": "B", "dtype": "str", "n_unique": 3, "value": "world"},
            ),
        ]

        expected_output = [
            Document(
                page_content="column: A",
                metadata={"file_name": "file1", "column": "A", "dtype": "int", "n_unique": 5, "values": [1]},
            ),
            Document(
                page_content="column: A",
                metadata={"file_name": "file2", "column": "A", "dtype": "int", "n_unique": 4, "values": [2]},
            ),
            Document(
                page_content="column: B",
                metadata={"file_name": "file2", "column": "B", "dtype": "str", "n_unique": 3, "values": ["world"]},
            ),
        ]

        result = self.processor.compress_documents(documents, query="")
        assert result == expected_output

    def test_empty_input(self):
        documents = []
        expected_output = []
        result = self.processor.compress_documents(documents, query="")
        assert result == expected_output


if __name__ == "__main__":
    unittest.main()
