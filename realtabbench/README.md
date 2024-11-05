# Benchmark Evaluations: A Variety of Academic and Table-Related Benchmark Evaluations for TableGPT2

## Overview

This folder is dedicated to evaluating TableGPT2 across diverse table-related benchmarks. Given the complexity and variability of table-based tasks and input instructions, we provide evaluation datasets and scripts covering several prominent benchmarks:

- ✨ **Table-Bench**: standardized table comprehension and reasoning tasks.
- ✨ **Text2SQL**: evaluates SQL generation capabilities from natural language queries.
- ✨ **TableInstruct**: a suite of benchmarks focused on various table-related tasks.
- ✨ **RealTabBench**: our custom benchmark specifically crafted to test LLMs on intricate, real-world tabular data scenarios, including irregular table structures, anonymized fields, and complex queries. *(Note: Only a portion of this benchmark is released here.)*

We utilize an inference framework based on local model paths using vLLM as the backend, with example prompt templates tailored for each benchmark.

## Usage

</div>

</details>

To use this framework, first clone the repository and install the necessary dependencies:

```shell
git clone https://github.com/tablegpt/tablegpt-agent
cd realtabbench
pip install -r requirements.txt
```

</div>

</details>

### Text2SQL Evaluation

Steps to Run

1.	download database files
The necessary database files are available on Google Drive. Download the files from the following URLs:
- [spider dev](https://drive.google.com/file/d/15xVsPLEVHXxyfczrAjYYKUEzFX6Jxjzn/view?usp=sharing)
- [spider test](https://drive.google.com/file/d/1O_Bs4Nw4vIjKx2T5IXUgjhG4AxVxCl78/view?usp=sharing)
- [bird dev](https://drive.google.com/file/d/1gXS8syJC0WcyDzX3LT2AdDxs9peWhsyV/view?usp=sharing)
- [RealTabBench](https://drive.google.com/file/d/1-PHf81VKlsI7jiREZ3v82UkHGUghrsTT/view?usp=sharing)

2.	extract files
Download and unzip each file into its respective directory:
   ```bash
   unzip bird_dev_database.zip -d realtabbench/evalset/bird_data \
   &&
   unzip spider_dev_database.zip -d realtabbench/evalset/spider_data \
   && 
   unzip spider_test_database.zip -d realtabbench/evalset/spider_data
   ```

3. run evaluation script
Execute the evaluation script to obtain accuracy metrics for the bird or spider datasets:
   ```bash
   python run_text2sql_eval.py --model_path <MODEL_PATH> \
   --eval_data_name <enum ["bird", "spider"]> \
   --mode <enum ["dev", "test"]>
   ```
