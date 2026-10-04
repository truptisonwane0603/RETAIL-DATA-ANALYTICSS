-- Q1 Average Delivery Time
SELECT
ROUND(
AVG(
JULIANDAY(order_delivered_customer_date) -
JULIANDAY(order_purchase_timestamp)
),2) AS Avg_Delivery_Days
FROM orders
WHERE order_status='delivered';
-- Q2 Average Shipping Time
SELECT
ROUND(
AVG(
JULIANDAY(order_delivered_carrier_date) -
JULIANDAY(order_purchase_timestamp)
),2)
AS Avg_Shipping_Days
FROM orders
WHERE order_status='delivered';
-- Q3 Average Carrier to Customer Time
SELECT
ROUND(
AVG(
JULIANDAY(order_delivered_customer_date) -
JULIANDAY(order_delivered_carrier_date)
),2)
AS Carrier_To_Customer
FROM orders
WHERE order_status='delivered';
-- Q4 Late Delivery %
SELECT
ROUND(
100.0*
SUM(
CASE
WHEN order_delivered_customer_date >
order_estimated_delivery_date
THEN 1
ELSE 0
END
)
/COUNT(*),2)
AS Late_Delivery_Percentage
FROM orders
WHERE order_status='delivered';
-- Q5 On-Time Delivery %
SELECT
ROUND(
100.0*
SUM(
CASE
WHEN order_delivered_customer_date<=order_estimated_delivery_date
THEN 1
ELSE 0
END
)
/COUNT(*),2)
AS On_Time_Delivery
FROM orders
WHERE order_status='delivered';
-- Q6 Freight Cost by State
SELECT
c.customer_state,
ROUND(SUM(oi.freight_value),2)
AS Freight
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_state
ORDER BY Freight DESC;
-- Q7 Highest Freight Orders
SELECT
order_id,
ROUND(SUM(freight_value),2)
AS Freight
FROM order_items
GROUP BY order_id
ORDER BY Freight DESC
LIMIT 20;
-- Q8 Freight Percentage
SELECT
ROUND(
SUM(freight_value)*100.0/
SUM(price),2)
AS Freight_Percentage
FROM order_items;

-- Q9 Average Freight by Seller
SELECT
seller_id,
ROUND(AVG(freight_value),2)
AS Avg_Freight
FROM order_items
GROUP BY seller_id
ORDER BY Avg_Freight DESC;

-- Q10 Delivery Days Distribution
SELECT

CASE

WHEN
(JULIANDAY(order_delivered_customer_date)-JULIANDAY(order_purchase_timestamp))<=3
THEN '0-3 Days'

WHEN
(JULIANDAY(order_delivered_customer_date)-JULIANDAY(order_purchase_timestamp))<=7
THEN '4-7 Days'

ELSE '8+ Days'

END Delivery_Group,

COUNT(*)

FROM orders

WHERE order_status='delivered'

GROUP BY Delivery_Group;

-- Q11 Fastest States
SELECT
c.customer_state,
ROUND(
AVG(
JULIANDAY(o.order_delivered_customer_date)-JULIANDAY(o.order_purchase_timestamp)
),2)
AS Avg_Days
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_status='delivered'
GROUP BY c.customer_state
ORDER BY Avg_Days;

-- Q12 Delivery Delay by Month
SELECT
strftime('%Y-%m',order_purchase_timestamp)
AS Month,
ROUND(
AVG(
JULIANDAY(order_delivered_customer_date)-JULIANDAY(order_estimated_delivery_date)
),2)
AS Avg_Delay
FROM orders
WHERE order_status='delivered'
GROUP BY Month;
Q13 Orders by Delivery Status
SELECT
order_status,
COUNT(*) Orders
FROM orders
GROUP BY order_status;

-- Q14 Average Delivery Time by Seller
SELECT
oi.seller_id,
ROUND(
AVG(
JULIANDAY(o.order_delivered_customer_date)-JULIANDAY(o.order_purchase_timestamp)
),2)
AS Avg_Delivery
FROM order_items oi
JOIN orders o
ON oi.order_id=o.order_id
WHERE o.order_status='delivered'
GROUP BY oi.seller_id;

-- Q15 Delivery Performance Score
SELECT
seller_id,
ROUND(
AVG(price)-AVG(freight_value),2)
AS Logistics_Score
FROM order_items
GROUP BY seller_id
ORDER BY Logistics_Score DESC;