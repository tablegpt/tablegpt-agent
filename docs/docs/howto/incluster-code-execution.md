# Incluster Code Execution

The `tablegpt-agent` directs `tablegpt` to generate Python code for data analysis. This code is then executed within a sandbox environment to ensure system security. The execution is managed by the [pybox](https://github.com/edwardzjl/pybox) library, which provides a simple way to run Python code outside the main process.


## Usage

If you're using the local executor (pybox.LocalPyBoxManager), follow these steps to configure the environment:


1. Install the dependencies required for the `IPython Kernel` using the following command:

    ```sh
    pip install -r ipython/requirements.txt
    ```

2. Copy the code from the `ipython/ipython-startup-scripts` folder to the `$HOME/.ipython/profile_default/startup/` directory.

    This folder contains the functions and configurations needed to perform data analysis with `tablegpt-agent`.

    Note: The `~/.ipython` directory must be writable for the process launching the kernel, otherwise there will be a warning message: `UserWarning: IPython dir '/home/jovyan/.ipython' is not a writable location, using a temp directory.` and the startup scripts won't take effects.
