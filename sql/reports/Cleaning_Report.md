# Customers Cleaning

## Missing Values

No missing values found.

## Duplicate Rows

No duplicate rows.

## customer_id

Unique.

## customer_unique_id

Duplicates are expected because one customer may place multiple orders.

## customer_state

Converted to uppercase.

## customer_city

Converted to lowercase and stripped whitespace.

## ZIP Code

Validated successfully.

Status:
Dataset cleaned successfully.


# Orders Cleaning

## Missing Values

Delivery timestamps missing only for cancelled/unfulfilled orders.

Kept unchanged.

## Duplicate Orders

No duplicate order_id.

## Foreign Keys

Validated with customers.

## Data Types

Converted timestamp columns to datetime.

## Business Validation

Verified delivery dates occur after purchase.

## Features Created

delivery_days

late_delivery

# Products Cleaning

## Missing Values

- Category names filled with "Unknown".
- Numeric attributes filled using median.

## Duplicate Products

- None found.

## Invalid Values

- Checked weights and dimensions.

## Data Types

- Converted integer-like columns to int.

## New Features

- product_volume_cm3
- density

## Status

Products dataset cleaned successfully.
## Product Weight

- Found 4 products with weight <= 0 g.
- Replaced them with the median positive weight.
- Detected potential outliers using the IQR method.
- Outliers were retained for further business analysis during EDA.

# Sellers Cleaning

## Missing Values
No missing values.

## Duplicate Sellers
No duplicate seller_id.

## Standardization
- seller_city → lowercase
- seller_state → uppercase

## ZIP Codes
Validated.

Status: Cleaned successfully.

# Order Items Cleaning

## Missing Values
No missing values.

## Composite Key
Validated (order_id + order_item_id).

## Foreign Keys
Validated against Orders, Products, and Sellers.

## Data Types
Converted shipping_limit_date to datetime.

## Engineered Features
- revenue
- freight_percentage
- order_value
- basket_size
- seller_revenue
- product_revenue
- avg_product_price
- avg_seller_freight

Status: Cleaned successfully.

# Payments Cleaning

Missing Values
No missing values.

Duplicate Validation
Validated composite key.

Payment Types
Standardized.

Installments
Validated.

Payment Value
Validated.

Status
Cleaned successfully.