-- -- CREATE VIEW customer_summary AS

-- -- SELECT

-- -- customer_id,

-- -- customer_total_orders,

-- -- customer_total_spent,

-- -- customer_avg_order_value,

-- -- repeat_customer

-- -- FROM customers_features;

-- -- CREATE VIEW seller_summary AS

-- -- SELECT

-- -- seller_id,

-- seller_total_orders

-- FROM sellers_features;

-- CREATE VIEW seller_summary AS

-- SELECT

-- seller_id,

-- seller_total_orders

-- FROM sellers_features;

-- CREATE VIEW revenue_summary AS

-- SELECT

-- order_id,

-- SUM(price) Revenue

-- FROM order_items

-- GROUP BY order_id;

CREATE VIEW vw_customer_summary AS
SELECT
customer_id,
customer_total_orders,
customer_total_spent,
customer_avg_order_value,
repeat_customer
FROM customers_features;

CREATE VIEW vw_product_summary AS
SELECT
product_id,
product_total_sales,
product_total_revenue,
product_avg_rating
FROM products_features;

CREATE VIEW vw_seller_summary AS
SELECT
seller_id,
seller_total_orders,
seller_total_revenue,
seller_avg_rating
FROM sellers_features;

CREATE VIEW vw_monthly_sales AS
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) Month,
SUM(oi.price) Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Month;

CREATE VIEW vw_monthly_sales AS
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) Month,
SUM(oi.price) Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Month;