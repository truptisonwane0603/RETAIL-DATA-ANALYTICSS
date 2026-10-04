SELECT
    strftime('%Y', o.order_purchase_timestamp) AS Year,
    strftime('%m', o.order_purchase_timestamp) AS Month,
    ROUND(SUM(oi.price),2) AS Monthly_Revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_status='delivered'
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT
    strftime('%Y', order_purchase_timestamp) AS Year,
    strftime('%m', order_purchase_timestamp) AS Month,
    COUNT(order_id) AS Total_Orders
FROM orders
WHERE order_status='delivered'
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT
    strftime('%Y', o.order_purchase_timestamp) AS Year,
    strftime('%m', o.order_purchase_timestamp) AS Month,
    ROUND(
        SUM(oi.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS Average_Order_Value
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_status='delivered'
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS Month,
    ROUND(SUM(oi.price),2) AS Revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_status='delivered'
GROUP BY Month
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    strftime('%Y', o.order_purchase_timestamp) AS Year,
    CASE
        WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN CAST(strftime('%m', o.order_purchase_timestamp) AS INTEGER) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,
    ROUND(SUM(oi.price),2) AS Revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.order_status='delivered'
GROUP BY Year, Quarter
ORDER BY Year, Quarter;