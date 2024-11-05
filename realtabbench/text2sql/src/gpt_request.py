import json
import logging
import os
import re
import sqlite3

import openai
from openai import AzureOpenAI
from tqdm import tqdm
from transformers import AutoTokenizer
from vllm import LLM, SamplingParams

logger = logging.getLogger(__name__)


def new_directory(path):
    if not os.path.exists(path):
        os.makedirs(path)


def load_json(data_path):
    with open(data_path) as f:
        return json.load(f)


def get_db_schemas(bench_root: str, db_name: str) -> dict[str, str]:
    """
    Read an sqlite file, and return the CREATE commands for each of the tables in the database.
    """
    asdf = "database" if bench_root == "spider" else "databases"
    with sqlite3.connect(f"file:{bench_root}/{asdf}/{db_name}/{db_name}.sqlite?mode=ro", uri=True) as conn:
        # conn.text_factory = bytes
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()
        schemas = {}
        for table in tables:
            cursor.execute(f"SELECT sql FROM sqlite_master WHERE type='table' AND name='{table[0]}';")  # noqa: S608
            schemas[table[0]] = cursor.fetchone()[0]

        return schemas


def nice_look_table(column_names: list, values: list):
    rows = []
    # Determine the maximum width of each column
    widths = [max(len(str(value[i])) for value in values + [column_names]) for i in range(len(column_names))]  # noqa: RUF005

    # Print the column names
    header = "".join(f"{column.rjust(width)} " for column, width in zip(column_names, widths))
    for value in values:
        row = "".join(f"{str(v).rjust(width)} " for v, width in zip(value, widths))
        rows.append(row)
    rows = "\n".join(rows)
    return header + "\n" + rows


def generate_schema_prompt(db_path, num_rows=None):
    # extract create ddls
    """
    :param root_place:
    :param db_name:
    :return:
    """
    conn = sqlite3.connect(db_path)
    # Create a cursor object
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = cursor.fetchall()
    schemas = {}
    for table in tables:
        if table == "sqlite_sequence":
            continue
        cursor.execute(f"SELECT sql FROM sqlite_master WHERE type='table' AND name='{table[0]}';")  # noqa: S608
        create_prompt = cursor.fetchone()[0]
        schemas[table[0]] = create_prompt
        if num_rows:
            cur_table = table[0]
            if cur_table in ["order", "by", "group"]:
                cur_table = f"`{cur_table}`"

            cursor.execute(f"SELECT * FROM {cur_table} LIMIT {num_rows}")  # noqa: S608
            column_names = [description[0] for description in cursor.description]
            values = cursor.fetchall()
            rows_prompt = nice_look_table(column_names=column_names, values=values)
            verbose_prompt = (
                f"/* \n {num_rows} example rows: \n SELECT * FROM {cur_table} LIMIT {num_rows}; \n {rows_prompt} \n */"  # noqa: S608
            )
            schemas[table[0]] = f"{create_prompt} \n {verbose_prompt}"

    full_schema_prompt_list = list(schemas.values())
    return "\n\n".join(full_schema_prompt_list)


def generate_comment_prompt(question, knowledge=None):
    pattern_prompt_no_kg = "-- Using valid SQLite, answer the following questions for the tables provided above."
    pattern_prompt_kg = "-- Using valid SQLite and understading External Knowledge, answer the following questions for the tables provided above."
    # question_prompt = "-- {}".format(question) + '\n SELECT '
    question_prompt = f"-- {question}"
    knowledge_prompt = f"-- External Knowledge: {knowledge}"

    if not knowledge:
        result_prompt = pattern_prompt_no_kg + "\n" + question_prompt
    else:
        result_prompt = knowledge_prompt + "\n" + pattern_prompt_kg + "\n" + question_prompt

    return result_prompt


def cot_wizard():
    # cot = "\nCarefully reason through each step to generate the SQL query:"
    return "\nGenerate the SQL after thinking step by step: "


def few_shot():
    ini_table = "CREATE TABLE singer\n(\n    singer_id         TEXT not null\n        primary key,\n    nation       TEXT  not null,\n    sname       TEXT null,\n    dname       TEXT null,\n    cname       TEXT null,\n    age    INTEGER         not null,\n    year  INTEGER          not null,\n    birth_year  INTEGER          null,\n    salary  REAL          null,\n    city TEXT          null,\n    phone_number   INTEGER          null,\n--     tax   REAL      null,\n)"
    ini_prompt = "-- External Knowledge: age = year - birth_year;\n-- Using valid SQLite and understading External Knowledge, answer the following questions for the tables provided above.\n-- How many singers in USA who is older than 27?\nThe final SQL is: Let's think step by step."
    ini_cot_result = "1. referring to external knowledge, we need to filter singers 'by year' - 'birth_year' > 27; 2. we should find out the singers of step 1 in which nation = 'US', 3. use COUNT() to count how many singers. Finally the SQL is: SELECT COUNT(*) FROM singer WHERE year - birth_year > 27;</s>"

    return ini_table + "\n" + ini_prompt + "\n" + ini_cot_result


def few_shot_no_kg():
    ini_table = "CREATE TABLE singer\n(\n    singer_id         TEXT not null\n        primary key,\n    nation       TEXT  not null,\n    sname       TEXT null,\n    dname       TEXT null,\n    cname       TEXT null,\n    age    INTEGER         not null,\n    year  INTEGER          not null,\n    age  INTEGER          null,\n    salary  REAL          null,\n    city TEXT          null,\n    phone_number   INTEGER          null,\n--     tax   REAL      null,\n)"
    ini_prompt = "-- External Knowledge:\n-- Using valid SQLite and understading External Knowledge, answer the following questions for the tables provided above.\n-- How many singers in USA who is older than 27?\nThe final SQL is: Let's think step by step."
    ini_cot_result = "1. 'older than 27' refers to age > 27 in SQL; 2. we should find out the singers of step 1 in which nation = 'US', 3. use COUNT() to count how many singers. Finally the SQL is: SELECT COUNT(*) FROM singer WHERE age > 27;</s>"

    return ini_table + "\n" + ini_prompt + "\n" + ini_cot_result


def generate_combined_prompts_one(db_path, question, knowledge=None):
    schema_prompt = generate_schema_prompt(db_path, num_rows=None)  # This is the entry to collect values
    comment_prompt = generate_comment_prompt(question, knowledge)

    return schema_prompt + "\n\n" + comment_prompt + cot_wizard()


def quota_giveup(e):
    return isinstance(e, openai.error.RateLimitError) and "quota" in str(e)


def connect_gpt(engine, prompt, max_tokens, temperature, stop):
    try:
        result = openai.Completion.create(
            engine=engine, prompt=prompt, max_tokens=max_tokens, temperature=temperature, stop=stop
        )
    except Exception as e:  # noqa: BLE001
        result = f"error:{e}"
    return result


def llm_generate_result(model_name_or_path, gpus_num, prompt_ls, args=None):  # noqa: ARG001
    logger.info("model: %s", model_name_or_path)
    tokenizer = AutoTokenizer.from_pretrained(model_name_or_path)
    logger.info("load tokenizer %s from %s over.", tokenizer.__class__, model_name_or_path)

    llm_args = {
        "model": model_name_or_path,
        "gpu_memory_utilization": 0.95,
        "trust_remote_code": True,
        "tensor_parallel_size": gpus_num,
        "dtype": "half",
        "max_model_len": 8192,
        "enforce_eager": True,
    }

    llm = LLM(**llm_args)
    sampling_params = SamplingParams(
        temperature=0,
        max_tokens=1024,
        top_p=0.95,
        stop_token_ids=[tokenizer.eos_token_id],
    )

    messages_list = []
    num = 0
    for prompt in tqdm(prompt_ls, desc="trans prompt"):
        message = [{"role": "user", "content": prompt}]
        messages_list.append(tokenizer.apply_chat_template(message, tokenize=False, add_generation_prompt=True))
        tk = tokenizer.apply_chat_template(message, tokenize=True, add_generation_prompt=True)
        if len(tk) > 7168:  # noqa: PLR2004
            print("=" * 100)  # noqa: T201
            # print(tk)
            num += 1
    # print("="*100, "cut nums: ", num)

    outputs = llm.generate(messages_list, sampling_params=sampling_params)
    generated_res = []
    ori_generated_res = []
    for _, output in enumerate(tqdm(outputs)):
        text = output.outputs[0].text
        ori_generated_res.append(text)
        sql = parser_sql(text)
        generated_res.append(sql)

    return generated_res, ori_generated_res


def gpt_generate_result(model_name_or_path, gpus_num, prompt_ls, args=None):  # noqa: ARG001
    client = AzureOpenAI(
        api_key=os.getenv("AZURE_OPENAI_API_KEY"),
        api_version="2024-07-01-preview",
        azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
        max_retries=3,
    )

    generated_res = []
    ori_generated_res = []

    output_name = os.path.join(
        args.data_output_path, f"{args.eval_data_name}_{args.mode}_{args.is_use_knowledge}_temp.json"
    )
    unparser_name = os.path.join(
        args.data_output_path, f"{args.eval_data_name}_{args.mode}_{args.is_use_knowledge}_unparser_temp.json"
    )

    if os.path.exists(unparser_name):
        ori_generated_res_dict = load_json(unparser_name)
        generated_res_dict = load_json(output_name)

        generated_res = [v for k, v in generated_res_dict.items()]
        ori_generated_res = [v for k, v in ori_generated_res_dict.items()]

    for i in tqdm(range(len(prompt_ls))):
        if i < len(generated_res):
            continue
        prompt = prompt_ls[i]
        response = client.chat.completions.create(
            model="gpt-4o", messages=[{"role": "user", "content": prompt}], temperature=0.01, timeout=40
        )

        generated_message = response.choices[0].message
        text = generated_message.content

        ori_generated_res.append(text)

        sql = parser_sql(text)
        generated_res.append(sql)

        if i % 50 == 0:
            generate_sql_file(sql_lst=generated_res, output_path=output_name)

            generate_sql_file(sql_lst=ori_generated_res, output_path=unparser_name)  # 未解析的结果保存

    return generated_res, ori_generated_res


def parser_sql(text):
    text = text.strip()
    sql_query_1 = re.search(r"```sql(.*?)```", text, re.DOTALL)
    sql_query_2 = re.search(r"```(.*?)```", text, re.DOTALL)
    if sql_query_1:
        extracted_sql = sql_query_1.group(1).strip()
    elif sql_query_2:
        extracted_sql = sql_query_2.group(1).strip()
    else:
        top_word = text.split(" ")[0]
        extracted_sql = "SELECT " + text if not top_word.lower().startswith("select") else text
    extracted_sql_ls = extracted_sql.split("\n")
    extracted_sql_ls = [s for s in extracted_sql_ls if not s.lower().startswith("-- ")]
    return "\n".join(extracted_sql_ls)


def collect_response_from_gpt(model_path, gpus_num, db_path_list, question_list, knowledge_list=None, args=None):
    """
    :param db_path: str
    :param question_list: []
    :return: dict of responses collected from llm
    """
    response_list = []

    prompt_ls = []
    for i in tqdm(range(len(question_list)), desc="get prompt"):
        # print('--------------------- processing {}th question ---------------------'.format(i))
        # print('the question is: {}'.format(question))
        question = question_list[i]
        if knowledge_list:
            cur_prompt = generate_combined_prompts_one(
                db_path=db_path_list[i], question=question, knowledge=knowledge_list[i]
            )
        else:
            cur_prompt = generate_combined_prompts_one(db_path=db_path_list[i], question=question)
        prompt_ls.append(cur_prompt)

    if args.use_gpt_api:
        outputs_sql, ori_outputs_text = gpt_generate_result(model_path, gpus_num, prompt_ls, args)
    else:
        outputs_sql, ori_outputs_text = llm_generate_result(model_path, gpus_num, prompt_ls, args)

    for i in tqdm(range(len(question_list)), desc="postprocess result"):
        question = question_list[i]
        sql = outputs_sql[i]

        db_id = db_path_list[i].split("/")[-1].split(".sqlite")[0]
        sql = sql + "\t----- bird -----\t" + db_id  # to avoid unpredicted \t appearing in codex results
        response_list.append(sql)

    return response_list, ori_outputs_text


def question_package(data_json, knowledge=False):  # noqa: ARG001, FBT002
    return [data["question"] for data in data_json]


def knowledge_package(data_json, knowledge=False):  # noqa: ARG001, FBT002
    return [data["evidence"] for data in data_json]


def decouple_question_schema(datasets, db_root_path):
    question_list = []
    db_path_list = []
    knowledge_list = []
    for _, data in enumerate(datasets):
        question_list.append(data["question"])
        cur_db_path = os.path.join(db_root_path, data["db_id"], f"{data['db_id']}.sqlite")
        db_path_list.append(cur_db_path)
        knowledge_list.append(data["evidence"])

    return question_list, db_path_list, knowledge_list


def generate_sql_file(sql_lst, output_path=None):
    result = {}
    for i, sql in enumerate(sql_lst):
        result[i] = sql

    if output_path:
        directory_path = os.path.dirname(output_path)
        new_directory(directory_path)
        with open(output_path, "w") as f:
            json.dump(result, f, indent=4)

    return result


def generate_main(eval_data, args):
    question_list, db_path_list, knowledge_list = decouple_question_schema(
        datasets=eval_data, db_root_path=args.db_root_path
    )
    assert len(question_list) == len(db_path_list) == len(knowledge_list)  # noqa: S101

    if args.use_knowledge == "True":
        responses, ori_outputs_text = collect_response_from_gpt(
            model_path=args.model_path,
            gpus_num=args.gpus_num,
            db_path_list=db_path_list,
            question_list=question_list,
            knowledge_list=knowledge_list,
            args=args,
        )
    else:
        responses, ori_outputs_text = collect_response_from_gpt(
            model_path=args.model_path,
            gpus_num=args.gpus_num,
            db_path_list=db_path_list,
            question_list=question_list,
            knowledge_list=None,
            args=args,
        )

    if args.chain_of_thought == "True":
        output_name = os.path.join(args.data_output_path, f"{args.eval_data_name}_{args.mode}_cot.json")
        # pdb.set_trace()
        generate_sql_file(sql_lst=responses, output_path=output_name)
    else:
        output_name = os.path.join(
            args.data_output_path, f"{args.eval_data_name}_{args.mode}_{args.is_use_knowledge}.json"
        )
        unparser_name = os.path.join(
            args.data_output_path, f"{args.eval_data_name}_{args.mode}_{args.is_use_knowledge}_unparser.json"
        )
        generate_sql_file(sql_lst=ori_outputs_text, output_path=unparser_name)  # 未解析的结果保存

    logger.info(
        "successfully collect results from %s for %s evaluation; Use knowledge: %s; Use COT: %s",
        args.model_path,
        args.mode,
        args.use_knowledge,
        args.chain_of_thought,
    )
    logger.info("output: %s", output_name)
    # 返回推理数据保存路径
    return output_name
