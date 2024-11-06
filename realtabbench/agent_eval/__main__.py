import asyncio
import logging
import os
import signal
import sys

from agent_eval.config import load_config
from agent_eval.evaluator import Evaluator
from dotenv import find_dotenv, load_dotenv
from langchain.globals import set_debug
from traitlets.log import get_logger

logger = logging.getLogger(__name__)


LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
set_debug(LOG_LEVEL.upper() == "TRACE")

# silent traitlets logs
traitlets_logger = get_logger()
traitlets_logger.setLevel("ERROR")


async def main() -> None:
    # Set up signal handling for graceful shutdown
    stop_event = asyncio.Event()
    # Windows does not support signal handling, we handle KeyboardInterrupt instead
    if sys.platform != "win32":
        loop = asyncio.get_running_loop()
        loop.add_signal_handler(signal.SIGINT, stop_event.set)
        loop.add_signal_handler(signal.SIGTERM, stop_event.set)

    config = load_config()
    evaluator = Evaluator(config)
    try:
        await evaluator.run(stop_event)
    except asyncio.exceptions.CancelledError:
        stop_event.set()
    except KeyboardInterrupt:
        # TODO: On Windows we should enter here. However we went to the except block above.
        logger.warning("Received CTRL+C, stopping...")
        stop_event.set()


if __name__ == "__main__":
    if sys.platform == "win32":
        asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

    load_dotenv(find_dotenv())
    asyncio.run(main())
