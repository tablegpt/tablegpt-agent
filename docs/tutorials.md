# Tutorials

## Installation

To install `tablegpt-agent`, use the following command:

```sh
pip install tablegpt-agent
```

This package depends on [pybox](https://github.com/edwardzjl/pybox), a Python code sandbox delegator. By default, `pybox` operates in an in-cluster mode. If you wish to run `tablegpt-agent` in a local environment, you need to install an optional dependency:

```sh
pip install pppybox[local]
```

## Start up

Before using `tablegpt-agent`, ensure that you have an OpenAI-compatible server set up to host TableGPT2. We recommend using [vllm](https://github.com/vllm-project/vllm) for this:

```sh
python -m vllm.entrypoints.openai.api_server --served-model-name TableGPT2-7B --model path/to/weights
```

> **Note:** For production environments, it's important to optimize the vllm server configuration. For details, refer to the [vllm documentation on server configuration](https://docs.vllm.ai/en/v0.6.0/serving/openai_compatible_server.html#command-line-arguments-for-the-server).

## Quick Start

To create a `TablegptAgent`, you'll need both `LLM` and `PyBoxManager` components:

```python
from langchain_openai import ChatOpenAI
from pybox import LocalPyBoxManager
from tablegpt.agent import create_tablegpt_graph

llm = ChatOpenAI(openai_api_base="YOUR_VLLM_URL", openai_api_key="whatever", model_name="TableGPT2-7B")
pybox_manager = LocalPyBoxManager()

agent = create_tablegpt_graph(
    llm=llm,
    pybox_manager=pybox_manager,
)
```

To interact with the agent:

```python
import asyncio
from datetime import date
from langchain_core.messages import HumanMessage

message = HumanMessage(content="Hi")

_input = {
    "messages": [message],
    "parent_id": "some-parent-id",
    "date": date.today(),
}
response = asyncio.run(agent.ainvoke(_input))
print(response["messages"])
```

```stdout
[HumanMessage(content='Hi', additional_kwargs={}, response_metadata={}, id='7da7e51c-0ad0-4481-aa22-54acce6a82d7'), AIMessage(content="Hello! How can I assist you with your data analysis today? Do you have a dataset you'd like to work with?", additional_kwargs={'parent_id': 'some-parent-id'}, response_metadata={}, id='43df249b-9c61-44bc-a535-eb33f9efaa9e')]
```

You can get more detailed outputs with the astream_events method:

```python
async for event in agent.astream_events(
    input=_input,
    version="v2",
):
    # We ignore irrelevant events here.
    if event["event"] == "on_chat_model_end":
        print(event["data"]["output"])
```

```stdout
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

## Data Analysis

Beyond simple conversations, `tablegpt-agent` can also analyze and process table data. For data analysis, preprocess the data first with TableGPT. Use a fixed session_id to keep the agent within the same execution context, and set a save point to enable memory retention:

```python
from langgraph.checkpoint.memory import MemorySaver

agent = create_tablegpt_graph(
    llm=llm,
    pybox_manager=pybox_manager,
    checkpointer=MemorySaver(),
    session_id="some-session-id",
)
```

Add the file for processing in the additional_kwargs of HumanMessage. Here's an example using the [Titanic dataset](https://github.com/tablegpt/tablegpt-agent/blob/main/examples/datasets/titanic.csv).

```python
from typing import TypedDict
from langchain_core.messages import HumanMessage

class Attachment(TypedDict):
    """Contains at least one dictionary with the key filename."""

    filename: str

attachment_msg = HumanMessage(
    content="",
    # Please make sure your iPython kernel can access your filename.
    additional_kwargs={"attachments": [Attachment(filename="titanic.csv")]},
)
```

Invoke the agent as shown in the quick start:

```python
import asyncio
from datetime import date
from tablegpt.agent.file_reading import Stage

# Reading and processing files.
response = asyncio.run(
    agent.ainvoke(
        input={
            "entry_message": attachment_msg,
            "processing_stage": Stage.UPLOADED,
            "messages": [attachment_msg],
            "parent_id": "some-parent-id1",
            "date": date.today(),
        },
        config={
            # Using checkpointer requires binding thread_id at runtime.
            "configurable": {"thread_id": "some-thread-id"},
        },
    )
)
print(response["messages"])
```

```stdout
[HumanMessage(content='', additional_kwargs={'attachments': [{'filename': 'titanic.csv'}]}, response_metadata={}, id='9cdbb5f5-3108-4abf-a782-836b92788e82'), AIMessage(content="我已经收到您的数据文件，我需要查看文件内容以对数据集有一个初步的了解。首先我会读取数据到 `df` 变量中，并通过 `df.info` 查看 NaN 情况和数据类型。\n```python\n# Load the data into a DataFrame\ndf = read_df('titanic.csv')\n\n# Remove leading and trailing whitespaces in column names\ndf.columns = df.columns.str.strip()\n\n# Remove rows and columns that contain only empty values\ndf = df.dropna(how='all').dropna(axis=1, how='all')\n\n# Get the basic information of the dataset\ndf.info(memory_usage=False)\n```", additional_kwargs={'parent_id': 'some-parent-id1', 'thought': '我已经收到您的数据文件，我需要查看文件内容以对数据集有一个初步的了解。首先我会读取数据到 `df` 变量中，并通过 `df.info` 查看 NaN 情况和数据类型。', 'action': {'tool': 'python', 'tool_input': "# Load the data into a DataFrame\ndf = read_df('titanic.csv')\n\n# Remove leading and trailing whitespaces in column names\ndf.columns = df.columns.str.strip()\n\n# Remove rows and columns that contain only empty values\ndf = df.dropna(how='all').dropna(axis=1, how='all')\n\n# Get the basic information of the dataset\ndf.info(memory_usage=False)"}, 'model_type': None}, response_metadata={}, id='463f1fab-5b5e-4811-a923-b1a31c6b825c', tool_calls=[{'name': 'python', 'args': {'query': "# Load the data into a DataFrame\ndf = read_df('titanic.csv')\n\n# Remove leading and trailing whitespaces in column names\ndf.columns = df.columns.str.strip()\n\n# Remove rows and columns that contain only empty values\ndf = df.dropna(how='all').dropna(axis=1, how='all')\n\n# Get the basic information of the dataset\ndf.info(memory_usage=False)"}, 'id': 'bfd54a9f-ddf8-45fc-90b0-3d669f4e63ca', 'type': 'tool_call'}]), ToolMessage(content=[{'type': 'text', 'text': "```pycon\n<class 'pandas.core.frame.DataFrame'>\nRangeIndex: 4 entries, 0 to 3\nData columns (total 8 columns):\n #   Column    Non-Null Count  Dtype  \n---  ------    --------------  -----  \n 0   Pclass    4 non-null      int64  \n 1   Sex       4 non-null      object \n 2   Age       4 non-null      float64\n 3   SibSp     4 non-null      int64  \n 4   Parch     4 non-null      int64  \n 5   Fare      4 non-null      float64\n 6   Embarked  4 non-null      object \n 7   Survived  4 non-null      int64  \ndtypes: float64(2), int64(4), object(2)\n```"}], name='python', id='34d1ab80-c742-49c8-a4a5-aa449a3f6ca3', tool_call_id='bfd54a9f-ddf8-45fc-90b0-3d669f4e63ca', artifact=[]), AIMessage(content='接下来我将用 `df.head(5)` 来查看数据集的前 5 行。\n```python\n# Show the first 5 rows to understand the structure\ndf.head(5)\n```', additional_kwargs={'parent_id': 'some-parent-id1', 'thought': '接下来我将用 `df.head(5)` 来查看数据集的前 5 行。', 'action': {'tool': 'python', 'tool_input': '# Show the first 5 rows to understand the structure\ndf.head(5)'}, 'model_type': None}, response_metadata={}, id='9bfa426f-f42a-433f-944f-020fc88273ad', tool_calls=[{'name': 'python', 'args': {'query': '# Show the first 5 rows to understand the structure\ndf.head(5)'}, 'id': '9f933c9c-4f6e-4632-a545-cbf9fb96d692', 'type': 'tool_call'}]), ToolMessage(content=[{'type': 'text', 'text': '```pycon\n   Pclass     Sex   Age  SibSp  Parch    Fare Embarked  Survived\n0       2  female  29.0      0      2  23.000        S         1\n1       3  female  39.0      1      5  31.275        S         0\n2       3    male  26.5      0      0   7.225        C         0\n3       3    male  32.0      0      0  56.496        S         1\n```'}], name='python', id='b1864c77-fc20-45aa-88b1-653478110dde', tool_call_id='9f933c9c-4f6e-4632-a545-cbf9fb96d692', artifact=[]), AIMessage(content='我已经了解了数据集 titanic.csv 的基本信息。请问我可以帮您做些什么？', additional_kwargs={'parent_id': 'some-parent-id1'}, response_metadata={}, id='05470ae0-22aa-4584-8b56-fcff4087d9e1')]
```

Continue to ask questions for data analysis:

```python
human_message = HumanMessage(content="How many men survived?")

async for event in agent.astream_events(
    input={
        # After using checkpoint, you only need to add new messages here.
        "messages": [human_message],
        "parent_id": "some-parent-id2",
        "date": date.today(),  # noqa: DTZ011
    },
    version="v2",
    # We configure the same thread_id to use checkpoints to retrieve the memory of the last run.
    config={"configurable": {"thread_id": "some-thread-id"}},
):
    event_name: str = event["name"]
    evt: str = event["event"]
    if evt == "on_chat_model_end":
        print(event["data"]["output"])
    elif event_name == "tools" and evt == "on_chain_stream":
        for lc_msg in event["data"]["chunk"]["messages"]:
            print(lc_msg)
    else:
        # Other events can be handled here.
        pass
```

```stdout
content='要确定有多少男性幸存，我们需要筛选出性别为 "male" 的行，并统计这些行中 `Survived` 列为 1 的数量。我将执行相应的代码来完成这个任务。\n```python\n# Filter the DataFrame to get only male passengers and count the survived ones\nmale_survived_count = df[(df[\'Sex\'] == \'male\') & (df[\'Survived\'] == 1)].shape[0]\n\nmale_survived_count\n```' additional_kwargs={} response_metadata={'finish_reason': 'stop', 'model_name': 'TableGPT2-7B'} id='run-88035693-c17d-41ec-b8d1-b80373a5a5a1'
content=[{'type': 'text', 'text': '```pycon\n1\n```'}] name='python' id='e05527a4-641c-4f26-a5c5-2e2960e23491' tool_call_id='02b9adc4-e2a7-49d1-9214-88d38104963d' artifact=[]
content='在提供的 Titanic 数据集中，有 1 名男性幸存。' additional_kwargs={} response_metadata={'finish_reason': 'stop', 'model_name': 'TableGPT2-7B'} id='run-49141ef6-818e-4837-9ddc-a77dff796e0e'
```

<details>

<summary>Full code</summary>

```python
import asyncio
from datetime import date
from typing import TypedDict

from langchain_core.messages import HumanMessage
from langchain_openai import ChatOpenAI
from langgraph.checkpoint.memory import MemorySaver
from pybox import LocalPyBoxManager
from tablegpt.agent import create_tablegpt_graph
from tablegpt.agent.file_reading import Stage


class Attachment(TypedDict):
    """Contains at least one dictionary with the key filename."""

    filename: str
    """The dataset uploaded in this session can be a filename, file path, or object storage address."""


# tablegpt-agent fully supports async invocation
async def main() -> None:
    llm = ChatOpenAI(openai_api_base="YOUR_VLLM_URL", openai_api_key="whatever", model_name="TableGPT2-7B")

    # Use local pybox manager for development and testing
    pybox_manager = LocalPyBoxManager()

    agent = create_tablegpt_graph(
        llm=llm,
        pybox_manager=pybox_manager,
        # We use MemorySaver as a checkpointer to record memory automatically.
        # See <https://langchain-ai.github.io/langgraph/concepts/persistence>
        checkpointer=MemorySaver(),
        # All code generated in this run will be executed in the kernel with kernel_id 'some-session-id'.
        session_id="some-session-id",
    )

    attachment_msg = HumanMessage(
        content="",
        # The dataset can be viewed in examples/datasets/titanic.csv.
        additional_kwargs={"attachments": [Attachment(filename="titanic.csv")]},
    )
    await agent.ainvoke(
        input={
            "entry_message": attachment_msg,
            "processing_stage": Stage.UPLOADED,
            "messages": [attachment_msg],
            "parent_id": "some-parent-id1",
            "date": date.today(),  # noqa: DTZ011
        },
        config={
            "configurable": {"thread_id": "some-thread-id"},
        },
    )

    human_message = HumanMessage(content="How many men survived?")

    async for event in agent.astream_events(
        input={
            # After using checkpoint, you only need to add new messages here.
            "messages": [human_message],
            "parent_id": "some-parent-id2",
            "date": date.today(),  # noqa: DTZ011
        },
        version="v2",
        # We configure the same thread_id to use checkpoints to retrieve the memory of the last run.
        config={"configurable": {"thread_id": "some-thread-id"}},
    ):
        print(event)  # noqa: T201


asyncio.run(main())
```

</details>
