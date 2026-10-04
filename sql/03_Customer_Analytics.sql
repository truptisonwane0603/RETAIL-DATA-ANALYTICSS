SELECT
COUNT(*) AS Total_Customers
FROM customers;

SELECT
COUNT(*) AS Repeat_Customers
FROM
(
    SELECT
        customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
);

SELECT
ROUND(
100.0 *
(
SELECT COUNT(*)
FROM
(
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*)>1
)
)
/
(
SELECT COUNT(*)
FROM customers
)
,2) AS Repeat_Customer_Percentage;

SELECT
c.customer_id,
ROUND(SUM(oi.price),2) AS Total_Spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_id
ORDER BY Total_Spent DESC
LIMIT 10;

SELECT
ROUND(
AVG(customer_spending),
2
) AS Average_Customer_Spend
FROM
(
SELECT
o.customer_id,
SUM(oi.price) AS customer_spending
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id
);

SELECT
o.customer_id,
COUNT(DISTINCT o.order_id) AS Total_Orders,
ROUND(SUM(oi.price),2) AS Lifetime_Value
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id
ORDER BY Lifetime_Value DESC;

SELECT
ROUND(
CAST(COUNT(order_id) AS REAL)
/COUNT(DISTINCT customer_id),
2
) AS Avg_Orders_Per_Customer
FROM orders;

SELECT
customer_state,
COUNT(*) AS Customers
FROM customers
GROUP BY customer_state
ORDER BY Customers DESC;

SELECT
customer_city,
COUNT(*) AS Customers
FROM customers
GROUP BY customer_city
ORDER BY Customers DESC
LIMIT 20;

SELECT
strftime('%Y',o.order_purchase_timestamp) AS Year,
strftime('%m',o.order_purchase_timestamp) AS Month,
COUNT(DISTINCT customer_id) AS New_Customers
FROM orders o
GROUP BY Year,Month
ORDER BY Year,Month;


SELECT
o.customer_id,
ROUND(
SUM(oi.price)
/COUNT(DISTINCT o.order_id),
2
) AS Avg_Order_Value
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id
ORDER BY Avg_Order_Value DESC
LIMIT 20;

SELECT
customer_id,
customer_total_spent,

CASE

WHEN customer_total_spent>=1000 THEN 'High Value'

WHEN customer_total_spent>=500 THEN 'Medium Value'

ELSE 'Low Value'

END AS Customer_Segment

FROM customers_features

ORDER BY customer_total_spent DESC;

SELECT
customer_id,
COUNT(order_id) AS Orders
FROM orders
GROUP BY customer_id
ORDER BY Orders DESC
LIMIT 10;

SELECT
DISTINCT c.customer_id
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
LEFT JOIN order_reviews r
ON o.order_id=r.order_id
WHERE r.review_id IS NULL;

SELECT
c.customer_state,
ROUND(
AVG(r.review_score),
2
) AS Avg_Review
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_reviews r
ON o.order_id=r.order_id
GROUP BY c.customer_state
ORDER BY Avg_Review DESC;