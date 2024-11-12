# Incluster Code Execution

The `tablegpt-agent` directs `tablegpt` to generate Python code for data analysis. This code is then executed within a sandbox environment to ensure system security. The execution is managed by the [pybox](https://github.com/edwardzjl/pybox) library, which provides a simple way to run Python code outside the main process.
