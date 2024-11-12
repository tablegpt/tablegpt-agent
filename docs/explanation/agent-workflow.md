# Agent Workflow

The Agent Workflow is the core functionality of the `tablegpt-agent`. It processes user input and generates appropriate responses. This workflow is similar to those found in most single-agent systems and consists of an agent and various tools. Specifically, the data analysis workflow includes:

- **An Agent Powered by TableGPT2**: This agent performs data analysis tasks.
- **An IPython tool**: This tool executes the generated code within a sandbox environment.

Additionally, TableGPT Agent offers several optional plugins that extend the agent's functionality:

- A Visual Language Model that can be used to enhance summarization for data visualization tasks.
- A retriever that fetches information about the dataset, improving the quality and relevance of the generated code.
- A safety mechanism that protects the system from toxic inputs.
