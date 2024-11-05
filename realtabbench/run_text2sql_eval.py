import argparse
import json

from text2sql.src.evaluation import evaluation_main
from text2sql.src.gpt_request import generate_main
from text2sql.src.gpt_request_encoder import generate_main_encoder


def main(args):
    if args.eval_data_name == "bird" and args.mode == "dev":
        args.db_root_path = "eval/evalset/bird_data/dev_databases"
        args.eval_data_path = "eval/evalset/bird_data/dev.json"
        args.ground_truth_path = "eval/evalset/bird_data/dev.sql"

    if args.eval_data_name == "spider" and args.mode == "test":
        args.db_root_path = "eval/evalset/spider_data/test_database"
        args.eval_data_path = "eval/evalset/spider_data/test.json"
        args.ground_truth_path = "eval/evalset/spider_data/test_gold.sql"

    if args.eval_data_name == "spider" and args.mode == "dev":
        args.db_root_path = "eval/evalset/spider_data/dev_database"
        args.eval_data_path = "eval/evalset/spider_data/dev.json"
        args.ground_truth_path = "eval/evalset/spider_data/dev_gold.sql"

    if args.is_use_knowledge:
        args.use_knowledge = "True"
    else:
        args.use_knowledge = "False"
    with open(args.eval_data_path) as f:
        eval_datas = json.load(f)
    if args.use_encoder:
        predicted_sql_path = generate_main_encoder(eval_datas, args)
    else:
        predicted_sql_path = generate_main(eval_datas, args)

    evaluation_main(args, eval_datas, predicted_sql_path)


if __name__ == "__main__":
    args_parser = argparse.ArgumentParser()
    args_parser.add_argument("--eval_type", type=str, choices=["ex"], default="ex")
    args_parser.add_argument("--eval_data_name", type=str, choices=["bird", "spider"], default="bird")
    args_parser.add_argument("--mode", type=str, choices=["dev", "test"], default="dev")
    args_parser.add_argument("--is_use_knowledge", default=True, action="store_true")
    args_parser.add_argument("--data_output_path", type=str, default="realtabbench/text2sql/output")
    args_parser.add_argument("--chain_of_thought", type=str, default="True")
    args_parser.add_argument("--model_path", type=str)  # , required=True
    args_parser.add_argument("--gpus_num", type=int, default=1)
    args_parser.add_argument("--num_cpus", type=int, default=4)
    args_parser.add_argument("--meta_time_out", type=float, default=30.0)
    args_parser.add_argument("--use_encoder", default=False, action="store_true")
    args_parser.add_argument("--use_gpt_api", default=False, action="store_true")

    args = args_parser.parse_args()
    main(args)
