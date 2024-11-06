from unittest.mock import patch

import pytest
from langchain_core.documents import Document
from pandas import DataFrame, Series
from tablegpt.retriever.loader import CSVLoader


@pytest.fixture
def mock_df():
    """Fixture to provide a mocked DataFrame."""
    return DataFrame({"column1": ["value1", "value2", "value3"], "column2": ["A", "B", "C"], "column3": [1, 2, 3]})


@pytest.fixture
def loader():
    """Fixture to provide a CSVLoader instance."""
    return CSVLoader(file_path="test.csv", extra_metadata={"source": "test_source"}, autodetect_encoding=True)


def test_initialization(loader):
    assert loader.file_path == "test.csv"
    assert loader.extra_metadata == {"source": "test_source", "filename": "test.csv"}
    assert loader.autodetect_encoding


def test_lazy_load(loader, mock_df):
    with (
        patch("tablegpt.retriever.loader.read_df", return_value=mock_df),
        patch.object(
            loader,
            "column2docs",
            return_value=iter(
                [
                    Document(
                        page_content="column1:value1",
                        metadata={"column": "column1", "dtype": "string", "value": "value1"},
                    ),
                    Document(
                        page_content="column1:value2",
                        metadata={"column": "column1", "dtype": "string", "value": "value2"},
                    ),
                ]
            ),
        ),
    ):
        documents = list(loader.lazy_load())
        assert len(documents) == 2
        assert documents[0].page_content == "column1:value1"
        assert documents[1].page_content == "column1:value2"


def test_lazy_load_with_missing_metadata(mock_df):
    loader = CSVLoader(file_path="test.csv", autodetect_encoding=True)
    with (
        patch("tablegpt.retriever.loader.read_df", return_value=mock_df),
        patch.object(
            loader,
            "column2docs",
            return_value=iter(
                [
                    Document(
                        page_content="column1:value1",
                        metadata={"column": "column1", "dtype": "string", "value": "value1"},
                    ),
                    Document(
                        page_content="column1:value2",
                        metadata={"column": "column1", "dtype": "string", "value": "value2"},
                    ),
                ]
            ),
        ),
    ):
        documents = list(loader.lazy_load())
        assert len(documents) == 2


def test_column2docs(loader, mock_df):
    column = Series(["value1", "value2", "value3"], name="column1")
    with patch("tablegpt.retriever.loader.read_df", return_value=mock_df):
        documents = list(loader.column2docs(column))
        assert len(documents) == 3
        assert documents[0].page_content == "column1:value1"
        assert documents[0].metadata["column"] == "column1"
        assert documents[0].metadata["value"] == "value1"


def test_empty_csv(loader):
    empty_df = DataFrame()
    with patch("tablegpt.retriever.loader.read_df", return_value=empty_df):
        documents = list(loader.lazy_load())
        assert documents == []


def test_csv_with_non_string_column(loader):
    df = DataFrame({"column1": [1, 2, 3], "column2": ["A", "B", "C"]})
    with patch("tablegpt.retriever.loader.read_df", return_value=df):
        documents = list(loader.lazy_load())
        assert len(documents) == 3
        assert documents[0].page_content == "column2:A"
        assert documents[1].page_content == "column2:B"
        assert documents[2].page_content == "column2:C"
