# TableGPT Evaluation

This document will guide you through the process of setting up the evaluation environment and running evaluations.

## Evaluation Datasets

Before running the evaluation, you need to create the evaluation datasets on Local.

In the evaluation context, the term "dataset" can be confusing because it has two different meanings. The first refers to evaluation datasets, which contain the samples you wish to evaluate. Each sample must have an 'input' field representing the user input and may optionally include an 'expected output' field if there is a ground truth answer to that input. The second definition refers to the dataset on which the user wants to perform analysis, which we refer to as 'reference data'.

### Input

We use LLM to assist in generating questions based on the input dataset. You can find the script [here](./questioner.py).

Please note that while our goal was to create a one-click solution for question generation, the current implementation may require some manual adjustments. Depending on your dataset, you might need to tweak the prompt accordingly. For instance, the default prompt aims to "uncover business value," which is not suitable for datasets related to diseases.

### Expected Output

While not all samples require an 'expected output' field, certain inputs—particularly those related to data analysis—do need a ground truth answer for comparison during evaluation. We use Agent Apps (such as ChatGPT, ChatGLM, etc.) to assist in generating the 'expected output.'

It's crucial to be meticulous when crafting the 'expected output' because it serves as the ground truth for evaluation. If the 'expected output' is incorrect, the evaluation results will be inaccurate.

## Installation

Create a virtual environment

```sh
python -m venv venv
source ./venv/bin/activate  # On Windows, use `.\venv\Scripts\activate`
```

Install dependencies for eval

```sh
pip install -r requirements.txt
```

## Configuration

The configuration file for evaluation is a YAML file (config.yaml by default). Refer to [example-config.yaml](./example-config.yaml) for detailed information.

## Run the evaluation script

Besides the config file, you need to set up some environment variables, either by exporting them or by creating a `.env` file in the root directory.

To run the evaluation script, use the following command:

```sh
python -m agent_eval --config path/to/your/config.yaml
```
