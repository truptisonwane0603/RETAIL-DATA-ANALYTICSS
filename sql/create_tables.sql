CREATE TABLE IF NOT EXISTS customers(
customer_id TEXT PRIMARY KEY,
customer_unique_id TEXT,
customer_zip_code_prefix INTEGER,
customer_city TEXT,
customer_state TEXT
);
CREATE TABLE IF NOT EXISTS orders(
order_id TEXT PRIMARY KEY,

customer_id TEXT,

order_status TEXT,

order_purchase_timestamp DATETIME,

order_approved_at DATETIME,

order_delivered_carrier_date DATETIME,

order_delivered_customer_date DATETIME,

order_estimated_delivery_date DATETIME,

FOREIGN KEY(customer_id)
REFERENCES customers(customer_id)
);
CREATE TABLE IF NOT EXISTS products(

product_id TEXT PRIMARY KEY,

product_category_name TEXT,

product_name_length INTEGER,

product_description_length INTEGER,

product_photos_qty INTEGER,

product_weight_g INTEGER,

product_length_cm INTEGER,

product_height_cm INTEGER,

product_width_cm INTEGER
);
CREATE TABLE IF NOT EXISTS sellers(

seller_id TEXT PRIMARY KEY,

seller_zip_code_prefix INTEGER,

seller_city TEXT,

seller_state TEXT
);
CREATE TABLE IF NOT EXISTS order_items(

order_id TEXT,

order_item_id INTEGER,

product_id TEXT,

seller_id TEXT,

shipping_limit_date DATETIME,

price REAL,

freight_value REAL,

PRIMARY KEY(order_id,order_item_id),

FOREIGN KEY(order_id)
REFERENCES orders(order_id),

FOREIGN KEY(product_id)
REFERENCES products(product_id),

FOREIGN KEY(seller_id)
REFERENCES sellers(seller_id)
);

CREATE TABLE IF NOT EXISTS order_payments (

order_id TEXT,

payment_sequential INTEGER,

payment_type TEXT,

payment_installments INTEGER,

payment_value REAL,

PRIMARY KEY(order_id, payment_sequential),

FOREIGN KEY(order_id)
REFERENCES orders(order_id)

);

CREATE TABLE IF NOT EXISTS order_reviews(

review_row_id INTEGER PRIMARY KEY AUTOINCREMENT,

review_id TEXT,

order_id TEXT,

review_score INTEGER,

review_comment_title TEXT,

review_comment_message TEXT,

review_creation_date DATETIME,

review_answer_timestamp DATETIME,

FOREIGN KEY(order_id)
REFERENCES orders(order_id)

);

CREATE TABLE IF NOT EXISTS geolocation(

geolocation_zip_code_prefix INTEGER,

geolocation_lat REAL,

geolocation_lng REAL,

geolocation_city TEXT,

geolocation_state TEXT
);

CREATE TABLE IF NOT EXISTS category_translation(

product_category_name TEXT PRIMARY KEY,
product_category_name_english TEXT

);