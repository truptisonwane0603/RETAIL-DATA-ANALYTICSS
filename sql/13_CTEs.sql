-- Q1 Monthly Revenue CTE
WITH monthly_sales AS
(
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) Month,
SUM(oi.price) Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Month
)

SELECT *

FROM monthly_sales;
-- Q2 Top Customers
WITH customer_revenue AS
(
SELECT
customer_id,
SUM(price) Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_id
)

SELECT *

FROM customer_revenue

ORDER BY Revenue DESC

LIMIT 20;
-- Q3 Revenue by Category
WITH category_sales AS
(
SELECT
ct.product_category_name_english Category,
SUM(oi.price) Revenue
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY Category
)

SELECT *

FROM category_sales

ORDER BY Revenue DESC;
-- Q4 Seller Performance
WITH seller_sales AS
(
SELECT
seller_id,
SUM(price) Revenue
FROM order_items
GROUP BY seller_id
)

SELECT *

FROM seller_sales

ORDER BY Revenue DESC;
-- Q5 High Value Customers
WITH customer_spending AS
(
SELECT
customer_id,
SUM(price) Spending
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_id
)

SELECT *

FROM customer_spending

WHERE Spending>1000;