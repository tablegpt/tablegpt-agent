# Continue Analysis on Generated Charts

While TableGPT2 excels in data analysis tasks, it currently lacks built-in support for visual modalities. Many data analysis tasks involve visualization, so to address this limitation, we provide an interface for integrating your own Visual Language Model (VLM) plugin.

When the agent performs a visualization task—typically using `matplotlib.pyplot.show`—the VLM will take over from the LLM, offering a more nuanced summarization of the visualization. This approach avoids the common pitfalls of LLMs in visualization tasks, which often either state, "I have plotted the data," or hallucinating the content of the plot.
