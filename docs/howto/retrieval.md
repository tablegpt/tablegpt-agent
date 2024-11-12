# Enhance TableGPT Agent with RAG

While the [File Reading Workflow](file-reading-workflow) is adequate for most scenarios, it may not always provide the information necessary for the LLM to generate accurate code. Consider the following examples:

- A categorical column in the dataset contains 'foo', 'bar', and 'baz', but 'baz' only appears after approximately 100 rows. In this case, the LLM may not encounter the 'baz' value through `df.head()`.
- The user's query may not align with the dataset's content for several reasons:
  - The dataset lacks proper governance. For instance, a cell value might be misspelled from 'foo' to 'fou'.
  - There could be a typo in the user's query. For example, if the user queries, "Show me the data for 'fou'," but the dataset contains 'foo' instead.

In such situations, the Dataset Retriever plugin can be utilized to fetch additional information about the dataset from external sources, thereby providing the LLM with more context and improving its ability to generate accurate responses.
