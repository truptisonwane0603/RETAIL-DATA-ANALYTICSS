SELECT
ROUND(SUM(price),2) AS Total_Revenue
FROM order_items;

SELECT
COUNT(DISTINCT order_id) AS Total_Orders
FROM orders;

SELECT
COUNT(*) AS Delivered_Orders
FROM orders
WHERE order_status='delivered';

SELECT
COUNT(*) AS Cancelled
FROM orders
WHERE order_status='canceled';

SELECT

ROUND(

100.0*

SUM(CASE
WHEN order_status='canceled'
THEN 1 ELSE 0 END)

/

COUNT(*)

,2)

AS Cancellation_Rate

FROM orders;


SELECT
COUNT(*)
FROM customers;

SELECT
COUNT(*)
FROM sellers;

SELECT
COUNT(*)
FROM products;

SELECT

ROUND(

SUM(price)

/

COUNT(DISTINCT order_id)

,2)

AS Average_Order_Value

FROM order_items;

SELECT

ROUND(

AVG(item_count)

,2)

FROM

(

SELECT

order_id,

COUNT(*) item_count

FROM order_items

GROUP BY order_id

);

SELECT

ROUND(

AVG(freight_value)

,2)

FROM order_items;


SELECT

ROUND(

SUM(freight_value)

,2)

FROM order_items;

SELECT

ROUND(

AVG(review_score)

,2)

FROM order_reviews;

SELECT

ROUND(

100.0*

SUM(

CASE

WHEN review_score=5

THEN 1

ELSE 0

END

)

/

COUNT(*)

,2)

FROM order_reviews;

SELECT

ROUND(

AVG(

JULIANDAY(order_delivered_customer_date)

-

JULIANDAY(order_purchase_timestamp)

)

,2)

AS Avg_Delivery_Days

FROM orders

WHERE order_status='delivered';