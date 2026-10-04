import sqlite3
import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

DB = BASE_DIR/"database"/"retail.db"
PROCESSED = BASE_DIR/"data"/"processed"

conn = sqlite3.connect(DB)

tables = {
    "customers_features":"customers_features.csv",
    "orders_features":"orders_features.csv",
    "products_features":"products_features.csv",
    "order_items_features":"order_items_features.csv",
    "payments_features":"payments_features.csv",
    "reviews_features":"reviews_features.csv",
    "sellers_features":"sellers_features.csv"
}

for table,file in tables.items():

    df = pd.read_csv(PROCESSED/file)

    df.to_sql(
        table,
        conn,
        if_exists="replace",
        index=False
    )

    print(f"{table} Loaded Successfully")

conn.close()

print("All Feature Tables Loaded.")

