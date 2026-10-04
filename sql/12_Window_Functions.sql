-- Q1 Product Revenue Rank
SELECT
product_id,
SUM(price) Revenue,
RANK() OVER(ORDER BY SUM(price) DESC) Revenue_Rank
FROM order_items
GROUP BY product_id;
-- Q2 Dense Rank Sellers
SELECT
seller_id,
SUM(price) Revenue,
DENSE_RANK() OVER(ORDER BY SUM(price) DESC) Rank_No
FROM order_items
GROUP BY seller_id;
-- Q3 Customer Spending Rank
SELECT
customer_id,
SUM(price) Spending,
ROW_NUMBER() OVER(ORDER BY SUM(price) DESC) Row_No
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_id;
-- Q4 Running Revenue
SELECT
strftime('%Y-%m',o.order_purchase_timestamp) Month,
SUM(oi.price) Revenue,
SUM(SUM(oi.price)) OVER(
ORDER BY strftime('%Y-%m',o.order_purchase_timestamp)
) Running_Revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY Month;
-- Q5 Monthly Revenue Growth
SELECT
Month,
Revenue,
Revenue-
LAG(Revenue)
OVER(ORDER BY Month)
Growth
FROM vw_monthly_sales;
-- Q6 Revenue Difference from Previous Month
SELECT
Month,
Revenue,
Revenue-
LAG(Revenue)
OVER(ORDER BY Month)
Difference
FROM vw_monthly_sales;
-- Q7 Top 3 Products per Category
SELECT *
FROM
(
SELECT
ct.product_category_name_english,
oi.product_id,
SUM(oi.price) Revenue,
ROW_NUMBER() OVER(
PARTITION BY ct.product_category_name_english
ORDER BY SUM(oi.price) DESC
) rn
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
GROUP BY ct.product_category_name_english,oi.product_id
)
WHERE rn<=3;