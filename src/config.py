"""
config.py

Stores all project paths.
"""

from pathlib import Path

# ----------------------------
# Project Root
# ----------------------------
BASE_DIR = Path(__file__).resolve().parent.parent

# ----------------------------
# Data Paths
# ----------------------------
RAW_DATA = BASE_DIR / "data" / "raw"

CLEANED_DATA = BASE_DIR / "data" / "cleaned"

PROCESSED_DATA = BASE_DIR / "data" / "processed"

# ----------------------------
# Database
# ----------------------------
DATABASE = BASE_DIR / "database" / "retail.db"

# ----------------------------
# SQL Folder
# ----------------------------
SQL_FOLDER = BASE_DIR / "sql"

# ----------------------------
# Logs
# ----------------------------
LOG_FOLDER = BASE_DIR / "logs"

LOG_FOLDER.mkdir(exist_ok=True)