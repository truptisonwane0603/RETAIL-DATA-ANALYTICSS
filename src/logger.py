"""
logger.py

Creates ETL log file.
"""

import logging

from config import LOG_FOLDER

logging.basicConfig(

    filename=LOG_FOLDER/"etl.log",

    level=logging.INFO,

    format="%(asctime)s | %(levelname)s | %(message)s"

)

logger = logging.getLogger(__name__)