# TableGPT Agent

[![PyPI - Version](https://img.shields.io/pypi/v/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)

-----

## Introduction

`tablegpt-agent` is a pre-built agent for TableGPT2 ([huggingface](https://huggingface.co/collections/tablegpt/tablegpt2-67265071d6e695218a7e0376)), a series of LLMs for table-based question answering. This agent is built on top of the [Langgraph](https://github.com/langchain-ai/langgraph) library and provides a simple interface for interacting with the TableGPT model.

## Installation

```sh
pip install tablegpt-agent
```

`tablegpt-agent` depends on [pybox](https://github.com/edwardzjl/pybox), which is a Python code sandbox delegator. `pybox` defaults to an in-cluster mode. If you want to run `tablegpt-agent` in a local environment, you need to install an optional dependency:

```sh
pip install pppybox[local]
```

## Quick Start

Before using `tablegpt-agent`, ensure you have an OpenAI-compatible server set up to host TableGPT2. We recommend using [vllm](https://github.com/vllm-project/vllm) for this:

```sh
python -m vllm.entrypoints.openai.api_server --served-model-name TableGPT2-7B --model path/to/weights
```

> Note: For production environments, it’s important to optimize the vllm server configuration. For details, refer to the [vllm documentation on server configuration](https://docs.vllm.ai/en/v0.6.0/serving/openai_compatible_server.html#command-line-arguments-for-the-server).

After setting up the server, you can use the following code to interact with the TableGPT model:

```python
from datetime import date

from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from tablegpt.agent import create_tablegpt_graph
from pybox import LocalPyBoxManager


llm = ChatOpenAI(openai_api_base=YOUR_VLLM_URL, openai_api_key="whatever", model_name="TableGPT2-7B")

pybox_manager = LocalPyBoxManager()

agent = create_tablegpt_graph(
  llm=llm,
  pybox_manager=app_state.pybox_manager,
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
```

<!-- API reference -->

## Workflow

### Main workflow

### File Upload workflow

### Code Execution

The `tablegpt-agent` directs `tablegpt` to generate python code for performing data analysis. This code is then executed within a sandbox environment to maintain system security. The execution is managed by the [pybox](https://github.com/edwardzjl/pybox) library, which offers a straightforward way to run Python code outside the main process.

### Plugins

  <!-- vlm -->
  <!-- guard chain -->
  <!-- RAG -->
  <!-- normalization chain -->

## Liscence

## Model Card

See [model_card.md](https://huggingface.co/tablegpt/tablegpt).

## Citation

If you find our work helpful, please cite us by

```

@misc{
}

```
