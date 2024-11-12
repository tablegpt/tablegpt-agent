# Quickstart

## Installation

To install `tablegpt-agent`, use the following command:

```sh
pip install tablegpt-agent
```

This package depends on [pybox](https://github.com/edwardzjl/pybox), a Python code sandbox delegator. By default, `pybox` operates in an in-cluster mode. If you wish to run `tablegpt-agent` in a local environment, you need to install an optional dependency:

```sh
pip install pppybox[local]
```

## Setup LLM Service

Before using `tablegpt-agent`, ensure that you have an OpenAI-compatible server set up to host TableGPT2. We recommend using [vllm](https://github.com/vllm-project/vllm) for this:

```sh
python -m vllm.entrypoints.openai.api_server --served-model-name TableGPT2-7B --model path/to/weights
```

> **Note:** For production environments, it's important to optimize the vllm server configuration. For details, refer to the [vllm documentation on server configuration](https://docs.vllm.ai/en/v0.6.0/serving/openai_compatible_server.html#command-line-arguments-for-the-server).

## Chat with TableGPT Agent

To create a `TablegptAgent`, you'll need both an `LLM` and a `PyBoxManager` instance:

```pycon
>>> from langchain_openai import ChatOpenAI
>>> from pybox import LocalPyBoxManager
>>> from tablegpt.agent import create_tablegpt_graph

>>> llm = ChatOpenAI(openai_api_base="YOUR_VLLM_URL", openai_api_key="whatever", model_name="TableGPT2-7B")
>>> pybox_manager = LocalPyBoxManager()

>>> agent = create_tablegpt_graph(
...     llm=llm,
...     pybox_manager=pybox_manager,
... )
```

To interact with the agent:

```pycon
>>> import asyncio
>>> from datetime import date
>>> from langchain_core.messages import HumanMessage

>>> message = HumanMessage(content="Hi")

>>> _input = {
...     "messages": [message],
...     "parent_id": "some-parent-id",
...     "date": date.today(),
... }

>>> response = asyncio.run(agent.ainvoke(_input))
>>> print(response["messages"])
[HumanMessage(content='Hi', additional_kwargs={}, response_metadata={}, id='7da7e51c-0ad0-4481-aa22-54acce6a82d7'), AIMessage(content="Hello! How can I assist you with your data analysis today? Do you have a dataset you'd like to work with?", additional_kwargs={'parent_id': 'some-parent-id'}, response_metadata={}, id='43df249b-9c61-44bc-a535-eb33f9efaa9e')]
```

You can get more detailed outputs with the `astream_events` method:

```pycon
>>> async for event in agent.astream_events(
...     input=_input,
...     version="v2",
... ):
...     # We ignore irrelevant events here.
...     if event["event"] == "on_chat_model_end":
...         print(event["data"]["output"])
content="Hello! How can I assist you with your data analysis today? Do you have a specific dataset or problem in mind that you'd like to work on?" additional_kwargs={} response_metadata={'finish_reason': 'stop', 'model_name': 'TableGPT2-7B'} id='run-677d42b7-ae79-4695-8e54-1b02fab07427'
```

<details>

<summary>Full code</summary>

```python
import asyncio
from datetime import date

from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from pybox import LocalPyBoxManager
from tablegpt.agent import create_tablegpt_graph


# tablegpt-agent fully supports async invocation
async def main() -> None:
    llm = ChatOpenAI(openai_api_base="YOUR_VLLM_URL", openai_api_key="whatever", model_name="TableGPT2-7B")

    # Use local pybox manager for development and testing
    pybox_manager = LocalPyBoxManager()

    agent = create_tablegpt_graph(
        llm=llm,
        pybox_manager=pybox_manager,
    )

    message = HumanMessage(content="Hi")
    _input = {
        "messages": [message],
        "parent_id": "some-parent-id",
        "date": date.today(),  # noqa: DTZ011
    }

    # response = await agent.ainvoke(_input)
    # print(response["messages"])

    # More details can be obtained through the astream_events method
    async for event in agent.astream_events(
        input=_input,
        version="v2",
    ):
        print(event)  # noqa: T201


asyncio.run(main())
```

</details>
