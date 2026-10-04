-- Q1 Revenue by State
SELECT
c.customer_state,
ROUND(SUM(oi.price),2)
Revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_state
ORDER BY Revenue DESC;
-- Q2 Orders by State
SELECT
customer_state,
COUNT(*) Orders
FROM customers
GROUP BY customer_state;
-- Q3 Customers by State
SELECT
customer_state,
COUNT(*) Customers
FROM customers
GROUP BY customer_state;
-- Q4 Revenue by City
SELECT
customer_city,
ROUND(SUM(oi.price),2)
Revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_city
ORDER BY Revenue DESC
LIMIT 20;
-- Q5 Top Cities by Orders
SELECT
customer_city,
COUNT(o.order_id) Orders
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY customer_city
ORDER BY Orders DESC
LIMIT 20;
-- Q6 Seller Distribution
SELECT
seller_state,
COUNT(*) Sellers
FROM sellers
GROUP BY seller_state;
-- Q7 Revenue by Seller State
SELECT
s.seller_state,
ROUND(SUM(oi.price),2)
Revenue
FROM sellers s
JOIN order_items oi
ON s.seller_id=oi.seller_id
GROUP BY seller_state;
-- Q8 Average Review by State
SELECT
customer_state,
ROUND(AVG(review_score),2)
Rating
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_reviews r
ON o.order_id=r.order_id
GROUP BY customer_state;
-- Q9 Freight by State
SELECT
customer_state,
ROUND(SUM(freight_value),2)
Freight
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_state;
-- Q10 Top Revenue Zip Codes
SELECT
customer_zip_code_prefix,
ROUND(SUM(oi.price),2)
Revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_zip_code_prefix
ORDER BY Revenue DESC
LIMIT 20;
