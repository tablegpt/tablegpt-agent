import argparse
import logging
from pathlib import Path
from typing import Any
from uuid import uuid4

import yaml
from pydantic import BaseModel, Field, PositiveInt
from pydantic_settings import BaseSettings, SettingsConfigDict

logger = logging.getLogger(__name__)


class DatasetSettings(BaseModel):
    name: str


class EvalSettings(BaseSettings):
    model_config = SettingsConfigDict(extra="ignore")

    run_name: str = Field(default_factory=lambda: f"eval-run-{uuid4()}")
    metadata: dict[str, Any]
    user: str = "eval-user"
    datasets: list[DatasetSettings]

    max_concurrency: PositiveInt = 1
    num_repetitions: PositiveInt = 1

    grader: dict[str, Any]


def load_config() -> dict[str, Any]:
    parser = argparse.ArgumentParser(description="Run the evaluation script.")
    parser.add_argument(
        "--config",
        type=str,
        default="config.yaml",
        help="Config file location.",
    )
    args = parser.parse_args()
    config_path = Path(args.config).absolute()
    if not config_path.exists():
        raise RuntimeError(f"Config file '{args.config}' not found")  # noqa: TRY003, EM102

    logger.info("Using config file: %s", config_path)
    with open(str(config_path)) as file:
        try:
            config = yaml.safe_load(file)
        except Exception:
            logger.exception("Error loading config file")
            raise

    return EvalSettings(**config)
