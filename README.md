# Retail Analytics

An end-to-end retail analytics project covering data preparation, exploratory analysis, SQL reporting, demand forecasting, customer segmentation, and recommendation experiments.

## Project contents

- `notebooks/` - analysis and machine-learning workflows
- `sql/` - schema, analytical queries, and reporting examples
- `src/` - reusable data-loading and project configuration code
- `populate_db.py` - loads CSV files into a local SQLite database

## Getting started

1. Create and activate a Python virtual environment.
2. Install the dependencies with `pip install -r requirements.txt`.
3. Put the source CSV files in `data/raw/`.
4. Run `python populate_db.py` to create `database/retail.db`.
5. Open the notebooks from the project root.

Datasets, databases, trained models, and generated outputs are intentionally excluded from this public repository. Add the data locally before running workflows that require it.