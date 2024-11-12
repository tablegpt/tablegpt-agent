# Normalize Datasets

The `Dataset Normalizer` plugin is used to transform 'pandas-unfriendly' datasets (e.g., Excel files that do not follow a standard tabular structure) into a more suitable format for pandas. It is backed by an LLM that generates Python code to convert the original datasets into new ones.

In `tablegpt-agent`, this plugin is used to better format 'pandas-unfriendly' datasets, making them more understandable for the subsequent steps. This plugin is optional; if used, it serves as the very first step in the [File Reading workflow](#file-reading-workflow), easing the difficulity of data analysis in the subsequent workflow.
