"""
database_loader.py

Professional ETL Pipeline
"""

import sqlite3

import pandas as pd

from config import *

import logger


print("=" * 50)
print("DATABASE PATH:", DATABASE_PATH)
print("=" * 50)

def connect_database():

    """
    Connect SQLite database.
    """
    
    connection = sqlite3.connect(DATABASE)

    logger.logger.info("Connected to SQLite Database.")

    return connection

def create_tables(connection):

    """
    Executes create_tables.sql
    """

    cursor = connection.cursor()

    with open(SQL_FOLDER/"create_tables.sql","r") as file:

        schema=file.read()

    cursor.executescript(schema)

    connection.commit()

    logger.logger.info("Tables Created Successfully.")

DATASETS={

"customers":
"olist_customers_dataset.csv",

"orders":
"olist_orders_dataset.csv",

"order_items":
"olist_order_items_dataset.csv",

"order_payments":
"olist_order_payments_dataset.csv",

"order_reviews":
"olist_order_reviews_dataset.csv",

"products":
"olist_products_dataset.csv",

"sellers":
"olist_sellers_dataset.csv",

"geolocation":
"olist_geolocation_dataset.csv",

"category_translation":
"product_category_name_translation.csv"

}

def load_csv(file_name):

    # """
    # Reads CSV file.
    # """

    path = RAW_DATA/file_name

    df = pd.read_csv(path)
    # Standardize column names
    df = standardize_column_names(df)


    logger.logger.info(f"{file_name} Loaded Successfully.")

    return df

def validate_empty(df,table):

    """
    Checks empty dataset.
    """

    if df.empty:

        logger.logger.error(f"{table} is Empty.")

        raise Exception(f"{table} Empty")

    logger.logger.info(f"{table} Validation Passed.")

def validate_primary_key(df,key,table):

    """
    Checks missing Primary Key.
    """

    missing=df[key].isnull().sum()

    if missing>0:

        logger.logger.error(

        f"{table}: {missing} Missing Primary Keys"

        )

        raise Exception("Missing Primary Key")

    logger.logger.info(

    f"{table}: Primary Key Validation Passed"

    )    
def validate_duplicate_primary_key(df, key_column, table_name):
    """
    Check for duplicate primary keys.
    """

    duplicate_count = df[key_column].duplicated().sum()

    if duplicate_count > 0:
        logger.logger.error(
            f"{table_name}: {duplicate_count} duplicate primary keys found."
        )
        raise ValueError(
            f"{table_name}: Duplicate Primary Keys"
        )

    logger.logger.info(
        f"{table_name}: Duplicate PK validation passed."
    )
EXPECTED_COLUMNS = {
    "customers": [
        "customer_id",
        "customer_unique_id",
        "customer_zip_code_prefix",
        "customer_city",
        "customer_state"
    ],

    "orders": [
        "order_id",
        "customer_id",
        "order_status",
        "order_purchase_timestamp",
        "order_approved_at",
        "order_delivered_carrier_date",
        "order_delivered_customer_date",
        "order_estimated_delivery_date"
    ],

    "products": [
        "product_id",
        "product_category_name",
        "product_name_length",
        "product_description_length",
        "product_photos_qty",
        "product_weight_g",
        "product_length_cm",
        "product_height_cm",
        "product_width_cm"
    ],

    "sellers": [
        "seller_id",
        "seller_zip_code_prefix",
        "seller_city",
        "seller_state"
    ]
}        

def validate_expected_columns(df, table_name):
    """
    Validate expected columns.
    """

    expected = EXPECTED_COLUMNS.get(table_name)

    if expected is None:
        return

    missing = set(expected) - set(df.columns)

    if missing:
        logger.logger.error(
            f"{table_name}: Missing Columns {missing}"
        )
        raise ValueError(
            f"{table_name}: Missing Columns"
        )

    logger.logger.info(
        f"{table_name}: Column validation passed."
    )
def validate_datatypes(df, table_name):
    """
    Display dataframe datatypes.
    """

    logger.logger.info(
        f"{table_name} Data Types:"
    )

    logger.logger.info(df.dtypes.to_string()) 


def insert_into_database(df, table_name, connection):
    """
    Insert dataframe into SQLite.
    """

    df.to_sql(
        table_name,
        connection,
        if_exists="append",
        index=False
    )

    connection.commit()

    logger.logger.info(
        f"{table_name}: Inserted Successfully."
    )
def verify_row_count(connection, table_name, expected_rows):
    """
    Verify imported rows.
    """

    query = f"""
    SELECT COUNT(*)
    FROM {table_name}
    """

    database_rows = pd.read_sql(query, connection).iloc[0, 0]

    if database_rows != expected_rows:

        logger.logger.error(
            f"{table_name}: Row Count Mismatch"
        )

        raise ValueError(
            "Row Count Validation Failed"
        )

    logger.logger.info(
        f"{table_name}: Row Count Verified ({database_rows})"
    )    
PRIMARY_KEYS = {
    "customers": "customer_id",
    "orders": "order_id",
    "products": "product_id",
    "sellers": "seller_id",
   
}

def process_table(connection, table_name, file_name):

    logger.logger.info(f"Processing {table_name}")

    df = load_csv(file_name)

    validate_empty(df, table_name)

    validate_expected_columns(df, table_name)

    key = PRIMARY_KEYS.get(table_name)

    if key:

        validate_primary_key(
            df,
            key,
            table_name
        )

        validate_duplicate_primary_key(
            df,
            key,
            table_name
        )

    validate_datatypes(
        df,
        table_name
    )

    insert_into_database(
        df,
        table_name,
        connection
    )

    verify_row_count(
        connection,
        table_name,
        len(df)
    )

    logger.logger.info(
        f"{table_name} Completed Successfully."
    )
def standardize_column_names(df):
    """
    Fix known column name inconsistencies.
    """

    df = df.rename(columns={
        "product_name_lenght": "product_name_length",
        "product_description_lenght": "product_description_length"
    })

    return df    

def main():

    logger.logger.info(
        "ETL Started"
    )

    connection = connect_database()

    create_tables(connection)

    for table, file in DATASETS.items():

        process_table(
            connection,
            table,
            file
        )

    connection.close()

    logger.logger.info(
        "ETL Completed Successfully"
    )

if __name__ == "__main__":
  main()

