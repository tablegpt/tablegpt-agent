# RealTabBench:  A varies of table-related benchmarks evaluations for tablegpt

## Overview

This is a repo opened for evaluation on different table-related benchmarks for tablegpt.

Given the complexity of table related tasks and the uncertainty of input instructions,  we prepare to provide evaluation datasets and scripts for 3 different table-related benchmarks:

- ✨Table-Bench.
- ✨Text2Sql.
- ✨TableInstruct,  which includes a series of table-related evaluation benchmarks.

We have built an inference method based on the  local model path using vLLM as the backend, and defined a set of example prompts templates for the above benchmarks.

Currently, we have only open-sourced the evaluation scripts and data for the Text2Sql task.

## Usage

</div>

</details>

⏬ To use this framework, please first install the repository from GitHub:

```shell
git clone https://github.com/tablegpt/tablegpt-agent
cd realtabbench
pip install -r requirements.txt
```

</div>

</details>

### Text2SQL evaluation

Running steps

1. The database files are shared in google drive. The file urls are as follows:

- [spider dev](https://drive.google.com/file/d/15xVsPLEVHXxyfczrAjYYKUEzFX6Jxjzn/view?usp=sharing)
- [spider test](https://drive.google.com/file/d/1O_Bs4Nw4vIjKx2T5IXUgjhG4AxVxCl78/view?usp=sharing)
- [bird dev](https://drive.google.com/file/d/1gXS8syJC0WcyDzX3LT2AdDxs9peWhsyV/view?usp=sharing)

1. Download and unzip all the zip files to the specified directories:

   ```bash
   unzip bird_dev_database.zip -d realtabbench/evalset/bird_data \
   &&
   unzip spider_dev_database.zip -d realtabbench/evalset/spider_data \
   && 
   unzip spider_test_database.zip -d realtabbench/evalset/spider_data
   ```

1. run eval script to get bird or spider metric(accuracy)

   ```bash
   python realtabbench/run_text2sql_eval.py --model_path <MODEL_PATH> \
   --eval_data_name <enum ["bird", "spider"]> \
   --mode <enum ["dev", "test"]>
   ```
