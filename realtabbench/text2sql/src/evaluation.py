import json
import logging
import os
import sqlite3
import sys

from func_timeout import FunctionTimedOut, func_timeout
from joblib import Parallel, delayed
from tqdm import tqdm

logger = logging.getLogger(__name__)


def load_json(dir):  # noqa: A002
    with open(dir) as j:
        return json.loads(j.read())


# def result_callback(result):
# exec_result.append(result)


def execute_sql(predicted_sql, ground_truth, db_path):
    conn = sqlite3.connect(db_path)
    # Connect to the database
    cursor = conn.cursor()
    cursor.execute(predicted_sql)
    predicted_res = cursor.fetchall()
    cursor.execute(ground_truth)
    ground_truth_res = cursor.fetchall()
    res = 0
    if set(predicted_res) == set(ground_truth_res):
        res = 1
    return {
        "res": res,
        "predicted_res": list(set(predicted_res)),
        "ground_truth_res": list(set(ground_truth_res)),
    }


def execute_model(sql_pair, db_place, idx, meta_time_out):
    predicted_sql, ground_truth = sql_pair
    try:
        res_dict = func_timeout(meta_time_out, execute_sql, args=(predicted_sql, ground_truth, db_place))
    except KeyboardInterrupt:
        sys.exit(0)
    except FunctionTimedOut:
        # result = [('timeout',)]
        res_dict = {"res": 0, "exec_detail": "timeout"}
    except Exception:  # noqa: BLE001
        # result = [('error',)]  # possibly len(query) > 512 or not executable
        res_dict = {"res": 0, "exec_detail": "error"}
    return {"sql_idx": idx, "res": res_dict["res"], "detail": res_dict}


def package_sqls(sql_path, db_root_path, mode="gpt", data_mode="dev"):  # noqa: ARG001
    clean_sqls = []
    db_path_list = []
    if mode == "gpt":
        with open(sql_path) as f:
            sql_data = json.load(f)
        for sql_str in sql_data.values():
            if isinstance(sql_str, str):
                sql, db_name = sql_str.split("\t----- bird -----\t")
            else:
                sql, db_name = " ", "financial"
            clean_sqls.append(sql)
            db_path_list.append(os.path.join(db_root_path, db_name, f"{db_name}.sqlite"))

    elif mode == "gt":
        with open(sql_path) as sqls:
            sql_txt = sqls.readlines()
        # sql_txt = [sql.split('\t')[0] for sql in sql_txt]
        for _, sql_str in enumerate(sql_txt):
            sql, db_name = sql_str.strip().split("\t")
            clean_sqls.append(sql)
            db_path_list.append(os.path.join(db_root_path, db_name, f"{db_name}.sqlite"))

    return clean_sqls, db_path_list


def run_sqls_parallel(sqls, db_places, num_cpus=1, meta_time_out=30.0):
    if num_cpus > 1:
        os.environ["TOKENIZERS_PARALLELISM"] = "false"
    return Parallel(n_jobs=num_cpus)(
        delayed(execute_model)(sqls[i], db_places[i], i, meta_time_out) for i in tqdm(range(len(sqls)), desc="exec")
    )


def sort_results(list_of_dicts):
    return sorted(list_of_dicts, key=lambda x: x["sql_idx"])


def compute_acc_by_diff(exec_results, contents):
    num_queries = len(exec_results)
    results = [res["res"] for res in exec_results]

    simple_results, moderate_results, challenging_results = [], [], []

    for i, content in enumerate(contents):
        if i >= len(exec_results):
            continue
        if content["difficulty"] == "simple":
            simple_results.append(exec_results[i])

        if content["difficulty"] == "moderate":
            moderate_results.append(exec_results[i])

        if content["difficulty"] == "challenging":
            challenging_results.append(exec_results[i])

    simple_acc = sum([res["res"] for res in simple_results]) / len(simple_results) if len(simple_results) != 0 else 0

    if len(moderate_results) != 0:
        moderate_acc = sum([res["res"] for res in moderate_results]) / len(moderate_results)
    else:
        moderate_acc = 0

    if len(challenging_results) != 0:
        challenging_acc = sum([res["res"] for res in challenging_results]) / len(challenging_results)
    else:
        challenging_acc = 0

    all_acc = sum(results) / num_queries
    count_lists = [
        len(simple_results),
        len(moderate_results),
        len(challenging_results),
        num_queries,
    ]
    return (
        simple_acc * 100,
        moderate_acc * 100,
        challenging_acc * 100,
        all_acc * 100,
        count_lists,
    )


def print_data(score_lists, count_lists):
    print(  # noqa: T201
        "======================================    ACCURACY    ====================================="
    )
    levels = ["simple", "moderate", "challenging", "total"]
    print("{:20} {:20} {:20} {:20} {:20}".format("", *levels))  # noqa: T201
    print("{:20} {:<20} {:<20} {:<20} {:<20}".format("count", *count_lists))  # noqa: T201

    print(  # noqa: T201
        "{:20} {:<20.2f} {:<20.2f} {:<20.2f} {:<20.2f}".format("accuracy", *score_lists)
    )


def evaluation_main(args, eval_datas, predicted_sql_path):
    exec_result = []

    pred_queries, db_paths = package_sqls(predicted_sql_path, args.db_root_path, mode="gpt", data_mode=args.mode)
    # generate gt sqls:
    gt_queries, db_paths_gt = package_sqls(args.ground_truth_path, args.db_root_path, mode="gt", data_mode=args.mode)

    query_pairs = list(zip(pred_queries, gt_queries))
    exec_result = run_sqls_parallel(
        query_pairs,
        db_places=db_paths,
        num_cpus=args.num_cpus,
        meta_time_out=args.meta_time_out,
    )
    exec_result = sort_results(exec_result)

    # save_result
    res = []
    for sql_pair, exec_res, data in zip(query_pairs, exec_result, eval_datas):
        predicted_sql, ground_truth = sql_pair
        exec_res["ground_truth"] = ground_truth
        exec_res["predicted_sql"] = predicted_sql
        exec_res["question"] = data["question"]
        exec_res["difficulty"] = data["difficulty"]
        res.append(exec_res)
    output_path = predicted_sql_path.replace(".json", "_exec.json")
    with open(output_path, "w") as f:
        json.dump(res, f, indent=4)

    print("start calculate")  # noqa: T201
    simple_acc, moderate_acc, challenging_acc, acc, count_lists = compute_acc_by_diff(exec_result, eval_datas)
    score_lists = [simple_acc, moderate_acc, challenging_acc, acc]
    print_data(score_lists, count_lists)
    print(  # noqa: T201
        "==========================================================================================="
    )
    print("Finished evaluation")  # noqa: T201
