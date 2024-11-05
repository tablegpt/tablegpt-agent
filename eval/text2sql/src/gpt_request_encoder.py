# 1. git clone -b v0.5.5-tablegpt-merged https://github.com/zTaoplus/vllm.git
# install tablegpt vllm


##  apply diff file (recommended in case of use only)
# 1. pip install vllm==0.5.5
# 2. cd vllm
# 3. git diff 09c7792610ada9f88bbf87d32b472dd44bf23cc2 HEAD -- vllm | patch -p1 -d "$(pip show vllm | grep Location | awk '{print $2}')"

## build from source (dev recommended)
## Note: Building from source may take 10-30 minutes and requires access to GitHub or other repositories. Make sure to configure an HTTP/HTTPS proxy.
## cd vllm && pip install -e . [-v]. The -v flag is optional and can be used to display verbose logs.


# see https://github.com/zTaoplus/TableGPT-hf to view the model-related configs.

import json
import logging
import os
import sqlite3
import warnings

# from io import StringIO
# from typing import Literal, List, Optional
# import pandas as pd
from text2sql.src.gpt_request import (
    cot_wizard,
    decouple_question_schema,
    generate_comment_prompt,
    generate_schema_prompt,
    generate_sql_file,
    parser_sql,
)
from tqdm import tqdm
from transformers import AutoTokenizer
from vllm import LLM
from vllm.sampling_params import SamplingParams

# 忽略所有警告
warnings.filterwarnings("ignore")


logger = logging.getLogger(__name__)


# DEFAULT_SYS_MSG = "You are a helpful assistant."
# ENCODER_TYPE = "contrastive"


def get_table_info(db_path, enum_num=None):
    # extract create ddls
    """
    :param root_place:
    :param db_name:
    :return:
    """
    # full_schema_prompt_list = []
    conn = sqlite3.connect(db_path)
    # Create a cursor object
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = cursor.fetchall()

    all_tables_info = []

    # 表截断
    # if len(tables) > 16:
    #     tables = random.sample(tables, 16)

    for table in tables:
        if table == "sqlite_sequence":
            continue

        # 前几行枚举值
        cur_table = f"`{table[0]}`"
        cursor.execute(f"SELECT * FROM {cur_table} LIMIT {enum_num}")  # noqa: S608
        row_ls = cursor.fetchall()

        cursor.execute(f"PRAGMA table_info({cur_table});")
        column_name_tp_ls = cursor.fetchall()

        all_columns_info = []
        for column_name_tp in column_name_tp_ls:
            pos_id = column_name_tp[0]  # 字段位置
            col_name = column_name_tp[1]  # 字段名
            col_type = column_name_tp[2]  # 字段类型

            # 字段枚举值
            contains_nan = False
            enum_values = []
            for row in row_ls:
                value = row[pos_id]
                if value is None:
                    contains_nan = True

                enum_values.append(str(value))

            if len(enum_values) == 0:
                enum_values = ["None"]

            single_columns_info = {
                "name": col_name,
                "dtype": col_type,
                "values": enum_values,
                "contains_nan": contains_nan,
                "is_unique": False,
            }
            all_columns_info.append(single_columns_info)

        # 列截断
        # if len(all_columns_info) > 32:
        #     all_columns_info = random.sample(all_columns_info, 32)
        single_table_info = {"columns": all_columns_info}
        all_tables_info.append(single_table_info)

    return all_tables_info


def generate_combined_prompts_one_encoder(db_path, question, knowledge=None):
    schema_prompt = generate_schema_prompt(db_path, num_rows=None)  # This is the entry to collect values
    comment_prompt = generate_comment_prompt(question, knowledge)
    # encoder_prompt = get_encoder_prompt(table_info)

    return schema_prompt + "\n\n" + comment_prompt + cot_wizard() + "\nSELECT "


def get_encoder_prompt(table_info):
    return "".join(f"table_{i} as follow:\n<TABLE_CONTENT>\n" for i in range(len(table_info)))


def get_messages_one(db_path, question, knowledge=None):
    table_info = get_table_info(db_path, enum_num=3)  # 采用几行枚举值

    prompt = generate_combined_prompts_one_encoder(db_path, question, knowledge=knowledge)

    messages = [{"role": "system", "content": "You are a helpul assistant."}]

    content = []
    for i in range(len(table_info)):
        if i == len(table_info) - 1:
            # 最后一个
            content.extend(
                [
                    {
                        "type": "text",
                        "text": f"table_{i} as follow: \n",
                    },
                    {"type": "table", "table": table_info[i]},
                    {
                        "type": "text",
                        "text": prompt,
                    },
                ]
            )
        else:
            content.extend(
                [
                    {
                        "type": "text",
                        "text": f"table_{i} as follow: \n",
                    },
                    {"type": "table", "table": table_info[i]},
                ]
            )

    messages.append({"role": "user", "content": content})
    return messages


def calculate_table_num():
    import os

    db_dir = "/home/jyuan/LLM/evaluation/table_related_benchmarks/evalset/bird_data/dev_databases"
    table_nums = []
    cols_nums = []
    for file in os.listdir(db_dir):
        if "." in file:
            continue
        db_path = os.path.join(db_dir, file, f"{file}.sqlite")
        # print(db_path)
        conn = sqlite3.connect(db_path)
        # Create a cursor object
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
        tables = cursor.fetchall()
        table_num = len(tables)
        table_nums.append(table_num)

        for table in tables:
            if table == "sqlite_sequence":
                continue

            # 前几行枚举值
            cur_table = f"`{table[0]}`"
            cursor.execute(f"PRAGMA table_info({cur_table});")
            column_name_tp_ls = cursor.fetchall()
            if len(column_name_tp_ls) == 115:  # noqa: PLR2004
                logger.info(db_path)
            cols_nums.append(len(column_name_tp_ls))
    cols_nums = sorted(cols_nums, reverse=True)

    logger.info("max table: %s, max columns: %s", max(table_nums), max(cols_nums))
    logger.info(cols_nums[:10])


def llm_generate_result_encoder(model_name_or_path, gpus_num, messages_ls):
    # 批量推理
    logger.info("model: %s", model_name_or_path)
    tokenizer = AutoTokenizer.from_pretrained(model_name_or_path)
    logger.info("load tokenizer %s from %s over.", tokenizer.__class__, model_name_or_path)

    model = LLM(
        model=model_name_or_path,
        max_model_len=12000,
        max_num_seqs=1,
        dtype="bfloat16",
        limit_mm_per_prompt={"table": 16},
        gpu_memory_utilization=0.9,
        tensor_parallel_size=gpus_num,
    )

    p = SamplingParams(temperature=0, max_tokens=1024)
    outputs = model.chat(messages=messages_ls, sampling_params=p)

    generated_res = []
    for _, output in enumerate(tqdm(outputs)):
        text = output.outputs[0].text
        sql = parser_sql(text)
        generated_res.append(sql)

    return generated_res


def col_nums_max(message):
    content = message[1]["content"]
    table_nums = 0
    col_nums_ls = []
    for dic in content:
        if dic["type"] == "table":
            table_nums += 1
            col_num = len(dic["table"]["columns"])
            col_nums_ls.append(col_num)
    return int(max(col_nums_ls) + 1), table_nums


def llm_generate_result_encoder_one(model_name_or_path, gpus_num, messages_ls):  # noqa: ARG001
    # 单条推理
    logger.info("model: %s", model_name_or_path)
    tokenizer = AutoTokenizer.from_pretrained(model_name_or_path)
    logger.info("load tokenizer %s from %s over.", tokenizer.__class__, model_name_or_path)

    model = LLM(
        model=model_name_or_path,
        max_model_len=12000,
        max_num_seqs=1,
        dtype="bfloat16",
        limit_mm_per_prompt={"table": 20},
        gpu_memory_utilization=0.9,
    )

    p = SamplingParams(temperature=0, max_tokens=1024)
    error_ls = []
    generated_res = []
    for i, messages in enumerate(messages_ls):
        try:
            outputs = model.chat(messages=messages, sampling_params=p)

            text = outputs[0].outputs[0].text
            sql = parser_sql(text)

        except Exception:  # noqa: BLE001
            error_ls.append(i)
            sql = ""
        generated_res.append(sql)
    if len(error_ls) != 0:
        with open("table_related_benchmarks/text2sql/output/error_ls.json", "w") as f:
            json.dump({"error_id": error_ls}, f, indent=4)
    return generated_res


def collect_response_from_gpt_encoder(model_path, gpus_num, db_path_list, question_list, knowledge_list=None):
    """
    :param db_path: str
    :param question_list: []
    :return: dict of responses collected from llm
    """
    responses_dict = {}  # noqa: F841
    response_list = []

    messages_ls = []
    for i in tqdm(range(len(question_list)), desc="get prompt"):
        question = question_list[i]
        db_path = db_path_list[i]

        if knowledge_list:
            messages = get_messages_one(db_path, question, knowledge=knowledge_list[i])
        else:
            messages = get_messages_one(db_path, question)
        messages_ls.append(messages)

    outputs_sql = llm_generate_result_encoder(model_path, gpus_num, messages_ls)
    for i in tqdm(range(len(outputs_sql)), desc="postprocess result"):
        question = question_list[i]
        sql = outputs_sql[i]

        db_id = db_path_list[i].split("/")[-1].split(".sqlite")[0]
        sql = sql + "\t----- bird -----\t" + db_id  # to avoid unpredicted \t appearing in codex results
        response_list.append(sql)

    return response_list


def generate_main_encoder(eval_data, args):
    question_list, db_path_list, knowledge_list = decouple_question_schema(
        datasets=eval_data, db_root_path=args.db_root_path
    )
    assert len(question_list) == len(db_path_list) == len(knowledge_list)  # noqa: S101

    if args.use_knowledge == "True":
        responses = collect_response_from_gpt_encoder(
            model_path=args.model_path,
            gpus_num=args.gpus_num,
            db_path_list=db_path_list,
            question_list=question_list,
            knowledge_list=knowledge_list,
        )
    else:
        responses = collect_response_from_gpt_encoder(
            model_path=args.model_path,
            gpus_num=args.gpus_num,
            db_path_list=db_path_list,
            question_list=question_list,
            knowledge_list=None,
        )

    if args.chain_of_thought == "True":
        output_name = os.path.join(args.data_output_path, f"predict_{args.mode}_cot.json")
    else:
        output_name = os.path.join(args.data_output_path, f"predict_{args.mode}.json")
    generate_sql_file(sql_lst=responses, output_path=output_name)

    logger.info(
        "successfully collect results from %s for %s evaluation; Use knowledge: %s; Use COT: %s; Use encoder: %s",
        args.model_path,
        args.mode,
        args.use_knowledge,
        args.chain_of_thought,
        args.use_encoder,
    )
    logger.info("output: %s", output_name)

    # 返回推理数据保存路径
    return output_name


def test_single():
    db_path = "/home/jyuan/LLM/evaluation/table_related_benchmarks/evalset/spider_data/test_database/aan_1/aan_1.sqlite"
    question = "How many authors do we have?"

    messages = get_messages_one(db_path, question, knowledge=None)

    model_name_or_path = "/data4/workspace/yss/models/longlin_encoder_model/contrastive"

    model = LLM(
        model=model_name_or_path,
        max_model_len=8192,
        max_num_seqs=16,
        dtype="bfloat16",
        limit_mm_per_prompt={"table": 10},
        gpu_memory_utilization=0.9,
        tensor_parallel_size=1,
    )
    p = SamplingParams(temperature=0, max_tokens=1024)
    res = model.chat(messages=messages, sampling_params=p)
    logger.info(res[0].outputs[0].text)


if __name__ == "__main__":
    calculate_table_num()
