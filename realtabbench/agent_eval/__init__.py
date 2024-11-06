import logging
import os

LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")


logger = logging.getLogger(__name__)
logger.setLevel(level=LOG_LEVEL)
