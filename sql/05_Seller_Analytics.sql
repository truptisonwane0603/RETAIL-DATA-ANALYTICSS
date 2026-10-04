-- Q1. Top Sellers by Revenue
SELECT
seller_id,
ROUND(SUM(price),2) Revenue
FROM order_items
GROUP BY seller_id
ORDER BY Revenue DESC
LIMIT 20;
-- Q2. Seller Order Count
SELECT
seller_id,
COUNT(DISTINCT order_id) Orders
FROM order_items
GROUP BY seller_id
ORDER BY Orders DESC;
-- Q3. Average Order Value by Seller
SELECT
seller_id,
ROUND(
SUM(price)/
COUNT(DISTINCT order_id),2)
Avg_Order_Value
FROM order_items
GROUP BY seller_id;
-- Q4. Seller Average Rating
SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2)
Rating
FROM order_items oi
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY oi.seller_id
ORDER BY Rating DESC;
-- Q5. Revenue by Seller State
SELECT
s.seller_state,
ROUND(SUM(oi.price),2)
Revenue
FROM sellers s
JOIN order_items oi
ON s.seller_id=oi.seller_id
GROUP BY seller_state
ORDER BY Revenue DESC;
-- Q6. Seller Count by State
SELECT
seller_state,
COUNT(*) Sellers
FROM sellers
GROUP BY seller_state;
-- Q7. Average Freight by Seller
SELECT
seller_id,
ROUND(AVG(freight_value),2)
Avg_Freight
FROM order_items
GROUP BY seller_id
ORDER BY Avg_Freight DESC;
-- Q8. Top Sellers by Units Sold
SELECT
seller_id,
COUNT(*) Units
FROM order_items
GROUP BY seller_id
ORDER BY Units DESC
LIMIT 20;
-- Q9. Seller Revenue Contribution %
SELECT
seller_id,
ROUND(
SUM(price)*100.0/
(
SELECT SUM(price)
FROM order_items
),2)
Revenue_Percentage
FROM order_items
GROUP BY seller_id
ORDER BY Revenue_Percentage DESC;
-- Q10. Seller Product Count
SELECT
seller_id,
COUNT(DISTINCT product_id)
Products
FROM order_items
GROUP BY seller_id;
-- Q11. Sellers with Highest Basket Value
SELECT
seller_id,
ROUND(AVG(price),2)
Avg_Item_Price
FROM order_items
GROUP BY seller_id
ORDER BY Avg_Item_Price DESC;

-- Q12. Top Rated Sellers (Minimum 20 Reviews)
SELECT
oi.seller_id,
COUNT(r.review_id) AS Total_Reviews,
ROUND(AVG(r.review_score),2) AS Avg_Rating
FROM order_items oi
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY oi.seller_id
HAVING COUNT(r.review_id)>=20
ORDER BY Avg_Rating DESC;

-- Q13. Sellers Serving Most States
SELECT
seller_id,
COUNT(DISTINCT c.customer_state) States_Served
FROM order_items oi
JOIN orders o
ON oi.order_id=o.order_id
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY seller_id
ORDER BY States_Served DESC;

-- Q14. Seller Monthly Revenue
SELECT
oi.seller_id,
strftime('%Y-%m',o.order_purchase_timestamp) Month,
ROUND(SUM(oi.price),2) Revenue
FROM order_items oi
JOIN orders o
ON oi.order_id=o.order_id
GROUP BY oi.seller_id,Month
ORDER BY Month;

-- Q15. Seller Performance Score
SELECT
seller_id,
ROUND(
AVG(price)+
AVG(freight_value),2)
Performance_Score
FROM order_items
GROUP BY seller_id
ORDER BY Performance_Score DESC;