-- Q1 Monthly Revenue
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) AS Month,
ROUND(SUM(oi.price),2) AS Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
WHERE o.order_status='delivered'
GROUP BY Month
ORDER BY Month;
-- Q2 Monthly Orders
SELECT
strftime('%Y-%m',order_purchase_timestamp) Month,
COUNT(*) Orders
FROM orders
GROUP BY Month
ORDER BY Month;
-- Q3 Monthly Customers
SELECT
strftime('%Y-%m',order_purchase_timestamp) Month,
COUNT(DISTINCT customer_id) Customers
FROM orders
GROUP BY Month;
-- Q4 Monthly Average Order Value
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) Month,
ROUND(
SUM(oi.price)/
COUNT(DISTINCT o.order_id),2)
AOV
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Month;
-- Q5 Monthly Freight
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) Month,
ROUND(SUM(oi.freight_value),2)
Freight
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Month;
-- Q6 Revenue by Weekday
SELECT
CASE strftime('%w',order_purchase_timestamp)
WHEN '0' THEN 'Sunday'
WHEN '1' THEN 'Monday'
WHEN '2' THEN 'Tuesday'
WHEN '3' THEN 'Wednesday'
WHEN '4' THEN 'Thursday'
WHEN '5' THEN 'Friday'
ELSE 'Saturday'
END Weekday,
COUNT(*) Orders
FROM orders
GROUP BY Weekday;
-- Q7 Orders by Hour
SELECT
strftime('%H',order_purchase_timestamp) Hour,
COUNT(*) Orders
FROM orders
GROUP BY Hour;
-- Q8 Quarterly Revenue
SELECT
strftime('%Y',o.order_purchase_timestamp) Year,
CASE
WHEN CAST(strftime('%m',o.order_purchase_timestamp) AS INTEGER)<=3 THEN 'Q1'
WHEN CAST(strftime('%m',o.order_purchase_timestamp) AS INTEGER)<=6 THEN 'Q2'
WHEN CAST(strftime('%m',o.order_purchase_timestamp) AS INTEGER)<=9 THEN 'Q3'
ELSE 'Q4'
END Quarter,
ROUND(SUM(oi.price),2) Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Year,Quarter;
-- Q9 Monthly Review Trend
SELECT
strftime('%Y-%m',review_creation_date) Month,
ROUND(AVG(review_score),2)
Rating
FROM order_reviews
GROUP BY Month;
-- Q10 Monthly Delivery Days
SELECT
strftime('%Y-%m',order_purchase_timestamp) Month,
ROUND(
AVG(
JULIANDAY(order_delivered_customer_date)-JULIANDAY(order_purchase_timestamp)
),2)
Delivery_Days
FROM orders
WHERE order_status='delivered'
GROUP BY Month;