# TableGPT Agent

[![PyPI - Version](https://img.shields.io/pypi/v/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)

-----

## Introduction

`tablegpt-agent` is a pre-built agent for TableGPT2 ([huggingface](https://huggingface.co/collections/tablegpt/tablegpt2-67265071d6e695218a7e0376)), a series of LLMs for table-based question answering. This agent is built on top of the [Langgraph](https://github.com/langchain-ai/langgraph) library and provides a user-friendly interface for interacting with TableGPT2.

## Installation

To install `tablegpt-agent`, use the following command:

```sh
pip install tablegpt-agent
```

This package depends on [pybox](https://github.com/edwardzjl/pybox), a Python code sandbox delegator. By default, `pybox` operates in an in-cluster mode. If you wish to run `tablegpt-agent` in a local environment, you need to install an optional dependency:

```sh
pip install pppybox[local]
```

## Quick Start

Before using `tablegpt-agent`, ensure that you have an OpenAI-compatible server set up to host TableGPT2. We recommend using [vllm](https://github.com/vllm-project/vllm) for this:

```sh
python -m vllm.entrypoints.openai.api_server --served-model-name TableGPT2-7B --model path/to/weights
```

> **Note:** For production environments, it’s important to optimize the vllm server configuration. For details, refer to the [vllm documentation on server configuration](https://docs.vllm.ai/en/v0.6.0/serving/openai_compatible_server.html#command-line-arguments-for-the-server).

Once the server is set up, you can use the following code to interact with the TableGPT model:

```python
import asyncio
from datetime import date

from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from tablegpt.agent import create_tablegpt_graph
from pybox import LocalPyBoxManager


# tablegpt-agent fully supports async invocation
async def main() -> None:
  llm = ChatOpenAI(openai_api_base=YOUR_VLLM_URL, openai_api_key="whatever", model_name="TableGPT2-7B")

  # Use local pybox manager for development and testing
  pybox_manager = LocalPyBoxManager()

  agent = create_tablegpt_graph(
    llm=llm,
    pybox_manager=pybox_manager,
  )

  message = HumanMessage(content="Hi")
  input = {
      "messages": [message],
      "parent_id": "some-parent-id",
      "date": date.today(),
  }


  async for event in agent.astream_events(
      input=input,
      version="v2",
  ):
      print(event)


asyncio.run(main())
```

<!-- TODO: Add API reference -->

## Components

### Data Analysis Workflow

The Data Analysis workflow is the core functionality of the `tablegpt-agent`. It processes user input and generates appropriate responses. This workflow is similar to those found in most single-agent systems and consists of an agent and various tools. Specifically, the data analysis workflow includes:

- **An Agent Powered by TableGPT2**: This agent performs data analysis tasks.
- **An IPython tool**: This tool executes the generated code within a sandbox environment.

Additionally, the data analysis workflow offers several optional plugins that extend the agent's functionality:

- [VLM](#vlm): A Visual Language Model that can be used to enhance summarization for data visualization tasks.
- [Dataset Retriever](#dataset-retriever): A retriever that fetches information about the dataset, improving the quality and relevance of the generated code.
- [Safaty Guard](#safaty-guard): A safety mechanism that protects the system from toxic inputs.

### File Reading Workflow

We separate the file reading workflow from the data analysis workflow to maintain greater control over how the LLM inspects the dataset files. Typically, if you let the LLM inspect the dataset itself, it uses the `df.head()` function to preview the data. While this is sufficient for basic cases, we have implemented a more structured approach by hard-coding the file reading workflow into several steps:

- `normalization` (optional): For some Excel files, the content may not be 'pandas-friendly'. We include an optional normalization step to transform the Excel content into a more suitable format for pandas.
- `df.info()`: Unlike `df.head()`, `df.info()` provides insights into the dataset's structure, such as the data types of each column and the number of non-null values, which also indicates whether a column contains NaN. This insight helps the LLM understand the structure and quality of the data.
- `df.head()`: The final step displays the first n rows of the dataset, where n is configurable. A larger value for n allows the LLM to glean more information from the dataset; however, too much detail may divert its attention from the primary task.

### Code Execution

The `tablegpt-agent` directs `tablegpt` to generate Python code for data analysis. This code is then executed within a sandbox environment to ensure system security. The execution is managed by the [pybox](https://github.com/edwardzjl/pybox) library, which provides a simple way to run Python code outside the main process.

### Plugins

`tablegpt-agent` provides several plugin interfaces for extending its functionality. These plugins are designed to be easily integrated into the agent and can be used to add new features or modify existing ones. The following plugins are available:

#### VLM

While TableGPT2 excels in data analysis tasks, it currently lacks built-in support for visual modalities. Many data analysis tasks involve visualization, so to address this limitation, we provide an interface for integrating your own Visual Language Model (VLM) plugin.

When the agent performs a visualization task—typically using `matplotlib.pyplot.show`—the VLM will take over from the LLM, offering a more nuanced summarization of the visualization. This approach avoids the common pitfalls of LLMs in visualization tasks, which often either state, "I have plotted the data," or hallucinating the content of the plot.

#### Dataset Retriever

While the [File Reading Workflow](file-reading-workflow) is adequate for most scenarios, it may not always provide the information necessary for the LLM to generate accurate code. Consider the following examples:

- A categorical column in the dataset contains 'foo', 'bar', and 'baz', but 'baz' only appears after approximately 100 rows. In this case, the LLM may not encounter the 'baz' value through `df.head()`.
- The user's query may not align with the dataset's content for several reasons:
  - The dataset lacks proper governance. For instance, a cell value might be misspelled from 'foo' to 'fou'.
  - There could be a typo in the user's query. For example, if the user queries, "Show me the data for 'fou'," but the dataset contains 'foo' instead.

In such situations, the Dataset Retriever plugin can be utilized to fetch additional information about the dataset from external sources, thereby providing the LLM with more context and improving its ability to generate accurate responses.

#### Safaty Guard

#### Dataset Normalizer

The `Dataset Normalizer` plugin is used to transform 'pandas-unfriendly' datasets (e.g., Excel files that do not follow a standard tabular structure) into a more suitable format for pandas. It is backed by an LLM that generates Python code to convert the original datasets into new ones.

In `tablegpt-agent`, this plugin is used to better format 'pandas-unfriendly' datasets, making them more understandable for the subsequent steps. This plugin is optional; if used, it serves as the very first step in the [File Reading workflow](#file-reading-workflow), easing the difficulity of data analysis in the subsequent workflow.

## Evaluation

This repository also includes a collection of evaluation scripts for table-related benchmarks. The evaluation scripts and datasets can be found in the `eval` directory. For more details, please refer to the [Evaluation README](eval/README.md).

## Liscence

`tablegpt-agent` is unser Apache-2.0 License. For more information, see the [LICENSE](LICENSE) file.

## Model Card

For more information about TableGPT2, see the [TableGPT2 Model Card](https://huggingface.co/tablegpt/tablegpt).

## Citation

If you find our work helpful, please cite us by

```bibtex
@misc{su2024tablegpt2largemultimodalmodel,
      title={TableGPT2: A Large Multimodal Model with Tabular Data Integration}, 
      author={Aofeng Su and Aowen Wang and Chao Ye and Chen Zhou and Ga Zhang and Guangcheng Zhu and Haobo Wang and Haokai Xu and Hao Chen and Haoze Li and Haoxuan Lan and Jiaming Tian and Jing Yuan and Junbo Zhao and Junlin Zhou and Kaizhe Shou and Liangyu Zha and Lin Long and Liyao Li and Pengzuo Wu and Qi Zhang and Qingyi Huang and Saisai Yang and Tao Zhang and Wentao Ye and Wufang Zhu and Xiaomeng Hu and Xijun Gu and Xinjie Sun and Xiang Li and Yuhang Yang and Zhiqing Xiao},
      year={2024},
      eprint={2411.02059},
      archivePrefix={arXiv},
      primaryClass={cs.LG},
      url={https://arxiv.org/abs/2411.02059}, 
}
```
