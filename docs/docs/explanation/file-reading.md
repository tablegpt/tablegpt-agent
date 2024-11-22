# File Reading

TableGPT Agent separates the file reading workflow from the data analysis workflow to maintain greater control over how the LLM inspects the dataset files. Typically, if you let the LLM inspect the dataset itself, it uses the `df.head()` function to preview the data. While this is sufficient for basic cases, we have implemented a more structured approach by hard-coding the file reading workflow into several steps:

- `normalization` (optional): For some Excel files, the content may not be 'pandas-friendly'. We include an optional normalization step to transform the Excel content into a more suitable format for pandas.
- `df.info()`: Unlike `df.head()`, `df.info()` provides insights into the dataset's structure, such as the data types of each column and the number of non-null values, which also indicates whether a column contains NaN. This insight helps the LLM understand the structure and quality of the data.
- `df.head()`: The final step displays the first n rows of the dataset, where n is configurable. A larger value for n allows the LLM to glean more information from the dataset; however, too much detail may divert its attention from the primary task.

<!-- Need a picture -->
