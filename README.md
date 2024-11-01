# TableGPT Agent

[![PyPI - Version](https://img.shields.io/pypi/v/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)

-----

## Table of Contents

- [TableGPT Agent](#tablegpt-agent)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Installation](#installation)
  - [Quick Start](#quick-start)
  - [Workflow](#workflow)
    - [Main workflow](#main-workflow)
    - [File Upload workflow](#file-upload-workflow)
    - [Code Execution](#code-execution)
    - [Plugins](#plugins)

## Introduction

`tablegpt-agent` is a pre-built agent for TableGPT ([github](https://github.com/tablegpt/tablegpt), [huggingface](https://huggingface.co/tablegpt/tablegpt)), an LLM for table-based question answering. This agent is built on top of the [Langgraph](https://github.com/langchain-ai/langgraph) library and provides a simple interface for interacting with the TableGPT model.

## Installation

```sh
pip install tablegpt-agent
```

`tablegpt-agent` depends on [pybox](https://github.com/edwardzjl/pybox), which is a Python code sandbox delegator. `pybox` defaults to an in-cluster mode. If you want to run `tablegpt-agent` in a local environment, you need to install an optional dependency:

```sh
pip install pppybox[local]
```

## Quick Start

```python
from datetime import date

from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from tablegpt.agent import create_tablegpt_graph
from pybox import LocalPyBoxManager


llm = ChatOpenAI()

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
