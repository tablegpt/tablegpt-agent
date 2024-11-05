import contextlib
import copy
import gc
import logging

import pandas as pd
import torch
from vllm import LLM
from vllm.distributed import destroy_distributed_environment, destroy_model_parallel
from vllm.sampling_params import SamplingParams
from vllm.utils import is_cpu

logger = logging.getLogger(__name__)


def extract_contrastive_table(df: pd.DataFrame):
    # Convert DataFrame to the desired format
    return {
        "columns": [
            {
                "name": col,
                "dtype": str(df[col].dtype),
                "contains_nan": df[col].isnull().any(),
                "is_unique": df[col].nunique() == len(df[col]),
                "values": df[col].tolist(),  # slice?
            }
            for col in df.columns
        ]
    }


def cleanup():
    destroy_model_parallel()
    destroy_distributed_environment()
    with contextlib.suppress(AssertionError):
        torch.distributed.destroy_process_group()
    gc.collect()
    if not is_cpu():
        torch.cuda.empty_cache()


def inference_with_encoder(args, format_msg_datas):
    logger.info("Load model...")
    model = LLM(
        model=args.model_path,
        max_model_len=args.max_model_len,
        gpu_memory_utilization=0.8,
        max_num_seqs=20,
        limit_mm_per_prompt={"table": 10},
        # dtype="half",
        dtype="bfloat16",
    )

    sparams = SamplingParams(temperature=args.temperature, max_tokens=args.max_new_tokens)
    model_outputs = model.chat(messages=format_msg_datas, sampling_params=sparams)
    model_outputs_text = [mot.outputs[0].text for mot in model_outputs]

    del model
    cleanup()
    return model_outputs_text


def truncate(value, max_length=80):
    if not isinstance(value, str) or len(value) <= max_length:
        return value
    return value[:max_length] + "..."


def format_encoder_tables(df_names, table_paths):
    tables = []
    tables_info = []
    for idx, table_path in enumerate(table_paths):
        df_name = df_names[idx]
        df = pd.read_csv(table_path, encoding="utf-8", nrows=500)
        df.columns = df.columns.str.strip()
        df = df.dropna(how="all").dropna(axis=1, how="all")
        # 限制超过列时截断
        max_columns = 50  # 可以根据你的需求设置这个数量
        if len(df.columns) > max_columns:
            df = df.iloc[:, :max_columns]

        df_extra_info = extract_contrastive_table(df)
        tables_info.append(copy.deepcopy(f"Details about the '{df_name}' other info as follows:\n<TABLE_CONTENT>\n"))
        tables.append(copy.deepcopy(df_extra_info))

    tables_list = [
        {
            "type": "table",
            "table": tb,
        }
        for tb in tables
    ]

    return tables_list, tables_info


def build_encoder_table_part_content(df_names, table_paths):
    content_msg = []
    for idx, table_path in enumerate(table_paths):
        content_msg.append(
            {
                "type": "text",
                "text": f"/*\nDetails about the '{df_names[idx]}' other info as follows:\n",
            }
        )
        # 读取df并处理
        df = pd.read_csv(table_path, encoding="utf-8", nrows=500)
        df.columns = df.columns.str.strip()
        df = df.dropna(how="all").dropna(axis=1, how="all")
        # 限制超过列时截断
        max_columns = 50  # 可以根据你的需求设置这个数量
        if len(df.columns) > max_columns:
            df = df.iloc[:, :max_columns]

        content_msg.append({"type": "table", "table": extract_contrastive_table(copy.deepcopy(df))})
        content_msg.append(
            {
                "type": "text",
                "text": "*/",
            }
        )

    return content_msg


def read_df_head(table_path, head_num=3, format_type="string"):
    df = pd.read_csv(table_path, encoding="utf-8", nrows=500)
    df.columns = df.columns.str.strip()
    df = df.dropna(how="all").dropna(axis=1, how="all")
    # 限制超过列时截断
    max_columns = 50  # 可以根据你的需求设置这个数量
    if len(df.columns) > max_columns:
        df = df.iloc[:, :max_columns]

    df_head = copy.deepcopy(df.head(head_num))
    df_truncated_head = df_head.apply(lambda x: x.map(lambda y: truncate(y, 80)))
    if format_type == "string":
        df_truncated_head_str = df_truncated_head.to_string()
    elif format_type == "md":
        df_truncated_head_str = df_truncated_head.to_markdown(index=False)
    else:
        df_truncated_head_str = df_truncated_head.to_string()
    return df_truncated_head_str, df
