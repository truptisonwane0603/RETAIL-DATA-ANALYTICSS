import sqlite3
import pandas as pd
from pathlib import Path

project_dir = Path(__file__).resolve().parent
data_dir = project_dir / "data" / "raw"
db_path = project_dir / "database" / "retail.db"
db_path.parent.mkdir(parents=True, exist_ok=True)

csv_files = list(data_dir.glob("*.csv"))

if not csv_files:
    print(f"Error: No CSV files found in {data_dir}.")
else:
    conn = sqlite3.connect(db_path)
    loaded_count = 0

    for csv_file in csv_files:
        # Clean up table names (e.g., olist_customers_dataset.csv -> customers)
        table_name = csv_file.stem.replace("olist_", "").replace("_dataset", "")
        
        print(f"Loading {csv_file.name} -> table '{table_name}'...")
        df = pd.read_csv(csv_file)
        df.to_sql(table_name, conn, if_exists="replace", index=False)
        print(f"  Created '{table_name}' with {len(df):,} rows")
        loaded_count += 1

    conn.close()
    print(f"\nSuccess! Loaded {loaded_count} tables into {db_path}")