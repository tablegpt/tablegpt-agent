# Code Sandbox

`tablegpt-agent` directs `tablegpt` to generate Python code for data analysis. However, the generated code may contain potential vulnerabilities or unexpected errors. Running such code directly in a production environment could threaten the system's stability and security.

`Code Sandbox` is designed to address this challenge. By leveraging sandbox technology, it confines code execution to a controlled environment, effectively preventing malicious or unexpected behaviors from impacting the main system. This provides an isolated and reliable space for running code safely.

`Code Sandbox` built on the [pybox](https://github.com/edwardzjl/pybox) library and supports three main execution modes:

- **Local Environment**: Executes code in a local sandbox for quick *deployment* and *validation*.  
- **Remote Environment**: Create remote environments through `Jupyter Enterprise Gateway` to achieve shared computing.
- **Cluster Environment**: Bypassing the need for proxy services such as `Jupyter Enterprise Gateway` by communicating directly with kernel pods.

Code Sandbox is designed based on the following key principles:

- **Security**: Limits code access using sandbox technology to ensure a safe and reliable execution environment.  
- **Isolation**: Provides independent execution environments for each task, ensuring strict separation of resources and data.  
- **Scalability**: Adapts to diverse computing environments, from local setups to Kubernetes clusters, supporting dynamic resource allocation and efficient task execution.


## Local Environment

In a local environment, Code Sandbox utilizes the `pybox` library to create and manage sandbox environments, providing a secure code execution platform. By isolating code execution from the host system's resources and imposing strict permission controls, it ensures safety and reliability. This approach is especially suitable for **development** and **debugging** scenarios.

If you want to run `tablegpt-agent` in a local environment, you can enable the **local mode**. Below are the installation steps and a detailed operation guide.

### Installing

To use `tablegpt-agent` in local mode, install the library with the following command:

```sh
pip install tablegpt-agent[local]
```

### Configuring

`tablegpt-agent` comes with several built-in features, such as auxiliary methods for data analysis and support for displaying Chinese fonts. **These features are automatically added to the sandbox environment by default**. If you need advanced customization (e.g., adding specific methods or fonts), refer to the [TableGPT IPython Kernel Configuration Documentation](https://github.com/tablegpt/tablegpt-agent/tree/main/ipython) for further guidance.

### Creating and Running

The following code demonstrates how to use the pybox library to set up a sandbox, execute code, and retrieve results in a local environment:

```python
from uuid import uuid4
from pybox import LocalPyBoxManager, PyBoxOut

# Initialize the local sandbox manager
pybox_manager = LocalPyBoxManager()

# Assign a unique Kernel ID for the sandbox
kernel_id = str(uuid4())

# Start the sandbox environment
box = pybox_manager.start(kernel_id)

# Define the test code to execute
test_code = """
import math
result = math.sqrt(16)
result
"""

# Run the code in the sandbox
out: PyBoxOut = box.run(code=test_code)

# Print the execution result
print(out)
```

### Example Output

After running the above code, the system will return the following output, indicating successful execution with no errors:
```text
data=[{'text/plain': '4.0'}] error=None
```

With `Code Sandbox` in local execution mode, developers can enjoy the safety of sandbox isolation at minimal cost while maintaining flexibility and efficiency. This lays a solid foundation for more complex remote or cluster-based scenarios.


## Remote Environment

In a remote environment, `Code Sandbox` uses the `pybox` library and its `RemotePyBoxManager` to create and manage sandbox environments. The remote mode relies on the [Enterprise Gateway](https://github.com/jupyter-server/enterprise_gateway) service to dynamically create and execute remote sandboxes. This mode allows multiple services to connect to the same remote environment, enabling shared access to resources. 

### Configuring

If `tablegpt-agent` is used in **remote mode**, the first step is to start the `enterprise_gateway` service. You can refer to the [Enterprise Gateway Deployment Guide](https://jupyter-enterprise-gateway.readthedocs.io/en/latest/operators/index.html#deploying-enterprise-gateway) for detailed instructions on configuring and starting the service.

Once the service is up and running, ensure that the service address is accessible. For example, assume the `enterprise_gateway` service is available at `http://example.com`.

### Creating and Running

The following code demonstrates how to create a remote sandbox using `RemotePyBoxManager` and execute code within it:

```python
from uuid import uuid4
from pybox import RemotePyBoxManager, PyBoxOut

# Initialize the remote sandbox manager, replacing with the actual Enterprise Gateway service address
pybox_manager = RemotePyBoxManager(host="http://example.com")

# Assign a unique Kernel ID
kernel_id = str(uuid4())

# Start the remote sandbox environment
box = pybox_manager.start(kernel_id)

# Define the test code
test_code = """
import math
result = math.sqrt(16)
result
"""

# Run the code in the sandbox
out: PyBoxOut = box.run(code=test_code)

# Print the execution result
print(out)
```

### Example Output

After executing the above code, the system will return the following output, indicating successful execution without any errors:

```plaintext
data=[{'text/plain': '4.0'}] error=None
```

### Advanced Environment Configuration

The `RemotePyBoxManager` provides the following advanced configuration options to allow for flexible customization of the sandbox execution environment:  

1. **`env_file`**: Allows you to load environment variables from a file to configure the remote sandbox.  
2. **`kernel_env`**: Enables you to pass environment variables directly as key-value pairs, simplifying the setup process.  

To learn more about the parameters and configuration options, refer to the [Kernel Environment Variables](https://jupyter-enterprise-gateway.readthedocs.io/en/latest/users/kernel-envs.html) documentation.


## Cluster Environment  

In a Kubernetes cluster, `Code Sandbox` leverages the `KubePyBoxManager` provided by the `pybox` library to create and manage sandboxes. Unlike the `remote environment`, the cluster environment **communicates directly with Kernel Pods** created by the [Jupyter Kernel Controller](https://github.com/edwardzjl/jupyter-kernel-controller), eliminating the need for an intermediary service like `Enterprise Gateway`.

### Configuring

Before using the cluster environment, you need to deploy the `jupyter-kernel-controller` service. You can quickly create the required CRDs and Deployments using the [Deploy Documentation](https://github.com/edwardzjl/jupyter-kernel-controller?tab=readme-ov-file#build-run-deploy).  

### Creating and Running

Once the `jupyter-kernel-controller` service is successfully deployed and running, you can create and run a cluster sandbox using the following code:  

```python
from uuid import uuid4
from pybox import KubePyBoxManager, PyBoxOut

# Initialize the cluster sandbox manager, replacing with actual paths and environment variable configurations
pybox_manager = KubePyBoxManager(
    env_file="YOUR_ENV_FILE_PATH",  # Path to the environment variable file
    kernel_env="YOUR_KERNEL_ENV_DICT",  # Kernel environment variable configuration
)

# Assign a unique Kernel ID
kernel_id = str(uuid4())

# Start the cluster sandbox environment
box = pybox_manager.start(kernel_id)

# Define the test code
test_code = """
import math
result = math.sqrt(16)
result
"""

# Run the code in the sandbox
out: PyBoxOut = box.run(code=test_code)

# Print the execution result
print(out)
```

### Example Output  

After executing the code above, the following output will be returned, indicating successful execution without any errors:  

```plaintext
data=[{'text/plain': '4.0'}] error=None
```

**NOTE:** The `env_file` and `kernel_env` parameters required by `KubePyBoxManager` are essentially the same as those for `RemotePyBoxManager`. For detailed information about these parameters, please refer to the [RemotePyBoxManager Advanced Environment Configuration](#advanced-environment-configuration).


With the above configuration, you can efficiently manage secure and reliable sandboxes in a Kubernetes cluster, supporting flexible control and extension of execution results.
