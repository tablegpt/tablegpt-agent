# TableGPT Agent

[![PyPI - Version](https://img.shields.io/pypi/v/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/tablegpt-agent.svg)](https://pypi.org/project/tablegpt-agent)

-----

## Introduction

`tablegpt-agent` is a pre-built agent for TableGPT2 ([huggingface](https://huggingface.co/collections/tablegpt/tablegpt2-67265071d6e695218a7e0376)), a series of LLMs for table-based question answering. This agent is built on top of the [Langgraph](https://github.com/langchain-ai/langgraph) library and provides a user-friendly interface for interacting with TableGPT2.

You can find the full document at <https://tablegpt.github.io/tablegpt-agent/>

## Evaluation

This repository also includes a collection of evaluation scripts for table-related benchmarks. The evaluation scripts and datasets can be found in the `eval` directory. For more details, please refer to the [Evaluation README](eval/README.md).

## Liscence

`tablegpt-agent` is distributed under the terms of the [Apache 2.0](https://spdx.org/licenses/Apache-2.0.html) license.

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
