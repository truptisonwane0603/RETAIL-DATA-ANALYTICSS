# Data Dictionary

This document outlines the purpose and columns of each table in the `retail.db` database.

### 1. customers
**Purpose:** Stores customer demographics and location data.
* `customer_id` (TEXT, PK): Unique identifier for the customer order profile.
* `customer_unique_id` (TEXT): Unique identifier for the actual person.
* `customer_zip_code_prefix` (INTEGER): First 5 digits of customer zip code.
* `customer_city` (TEXT): Customer city.
* `customer_state` (TEXT): Customer state.

### 2. orders
**Purpose:** Core table tracking all order statuses and timestamps.
* `order_id` (TEXT, PK): Unique identifier for the order.
* `customer_id` (TEXT, FK): Reference to the customer table.
* `order_status` (TEXT): Current status of the order (e.g., delivered, shipped).
* `order_purchase_timestamp` (DATETIME): When the purchase was made.
* `order_approved_at` (DATETIME): When payment was approved.
* `order_delivered_carrier_date` (DATETIME): When the order was handed to logistics.
* `order_delivered_customer_date` (DATETIME): When the order reached the customer.
* `order_estimated_delivery_date` (DATETIME): The original estimated delivery date.

### 3. products
**Purpose:** Details about the items being sold.
* `product_id` (TEXT, PK): Unique identifier for the product.
* `product_category_name` (TEXT): Root category of the product.
* `product_name_length` (INTEGER): Character length of the product name.
* `product_description_length` (INTEGER): Character length of the description.
* `product_photos_qty` (INTEGER): Number of photos published.
* `product_weight_g` (INTEGER): Weight in grams.
* `product_length_cm`, `product_height_cm`, `product_width_cm` (INTEGER): Dimensions.

### 4. sellers
**Purpose:** Information about the merchants fulfilling the orders.
* `seller_id` (TEXT, PK): Unique identifier for the seller.
* `seller_zip_code_prefix` (INTEGER): Seller's location zip prefix.
* `seller_city` (TEXT): Seller city.
* `seller_state` (TEXT): Seller state.

### 5. order_items
**Purpose:** Line items within each order, linking products, sellers, and orders.
* `order_id` (TEXT, FK): Reference to the order.
* `order_item_id` (INTEGER): Sequential number identifying number of items in the same order.
* `product_id` (TEXT, FK): Reference to the product.
* `seller_id` (TEXT, FK): Reference to the seller.
* `shipping_limit_date` (DATETIME): Seller shipping deadline.
* `price` (REAL): Item price.
* `freight_value` (REAL): Item freight (shipping) cost.

### 6. order_payments
**Purpose:** Records payment methods and values for orders.
* `order_id` (TEXT, FK): Reference to the order.
* `payment_sequential` (INTEGER): Sequence of payment methods used.
* `payment_type` (TEXT): Method of payment (credit card, voucher, etc.).
* `payment_installments` (INTEGER): Number of installments chosen.
* `payment_value` (REAL): Transaction value.

### 7. order_reviews
**Purpose:** Customer reviews and ratings for their orders.
* `review_id` (TEXT, PK): Unique review identifier.
* `order_id` (TEXT, FK): Reference to the order.
* `review_score` (INTEGER): Rating from 1 to 5.
* `review_comment_title` (TEXT): Review title.
* `review_comment_message` (TEXT): Review body.
* `review_creation_date` (DATETIME): Date review survey was sent.
* `review_answer_timestamp` (DATETIME): Time the review was submitted.

### 8. geolocation
**Purpose:** Mapping zip codes to exact lat/long coordinates.
* `geolocation_zip_code_prefix` (INTEGER): First 5 digits of zip code.
* `geolocation_lat` (REAL): Latitude.
* `geolocation_lng` (REAL): Longitude.
* `geolocation_city` (TEXT): City name.
* `geolocation_state` (TEXT): State abbreviation.

### 9. category_translation
**Purpose:** Lookup table to translate Portuguese category names to English.
* `product_category_name` (TEXT, PK): Category name in native language.
* `product_category_name_english` (TEXT): Category name in English.