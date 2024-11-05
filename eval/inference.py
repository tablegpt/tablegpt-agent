import os
import pathlib

from transformers import AutoTokenizer
from vllm import LLM, SamplingParams


def get_infer_kwargs(args) -> dict:
    """llm_inference kwargs"""
    temperature = args.temperature if args.temperature else 1.0
    max_new_tokens = args.max_new_tokens if args.max_new_tokens else 1024
    model_type = args.model_type if args.model_type else "chat_model"

    return {
        "temperature": temperature,
        "max_tokens": max_new_tokens,
        "model_type": model_type,
    }


def load_tokenizer_and_template(model_name_or_path, template=None):
    tokenizer = AutoTokenizer.from_pretrained(model_name_or_path, trust_remote_code=True)

    if tokenizer.chat_template is None:
        if template is not None:
            chatml_jinja_path = (
                pathlib.Path(os.path.dirname(os.path.abspath(__file__))) / f"templates/template_{template}.jinja"
            )
            assert chatml_jinja_path.exists()  # noqa: S101
            with open(chatml_jinja_path) as f:
                tokenizer.chat_template = f.read()
        else:
            pass
            # raise ValueError("chat_template is not found in the config file, please provide the template parameter.")
    return tokenizer


def load_model(model_name_or_path, max_model_len=None, gpus_num=1):
    llm_args = {
        "model": model_name_or_path,
        "gpu_memory_utilization": 0.95,
        "trust_remote_code": True,
        "tensor_parallel_size": gpus_num,
        "dtype": "half",
    }

    if max_model_len:
        llm_args["max_model_len"] = max_model_len

    # Create an LLM.
    return LLM(**llm_args)


def generate_outputs(messages_batch, llm_model, tokenizer, generate_args):
    """
    messages = [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": prompt}
    ]

    messages_batch = [messages]

    generate_args = {
        "max_new_tokens": 1024,
        "do_sample": True or False,
        "temperature": 0-1,
        ""
    }
    """
    model_type = generate_args.pop("model_type", "chat_model")
    # 添加一个默认参数, 抑制instruct-following能力较差的模型, 输出重复内容, 考虑加入参数配置
    # generate_args["presence_penalty"] = 2.0
    sampling_params = SamplingParams(**generate_args)

    prompt_batch = []
    for messages in messages_batch:
        # 如果是basemodel, 直接拼接prompt内容后输入到模型
        if model_type == "base_model":
            messages_content = [msg["content"] for msg in messages]
            prompt = "\n".join(messages_content)
        # 如果是chat—model 则拼接chat-template后输入
        else:
            prompt = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
        prompt_batch.append(prompt)

    outputs = llm_model.generate(prompt_batch, sampling_params)

    outputs_batch = []
    for output in outputs:
        prompt_output = output.prompt
        generated_text = output.outputs[0].text
        outputs_batch.append({"input_prompt": prompt_output, "output_text": generated_text})

    return outputs_batch
