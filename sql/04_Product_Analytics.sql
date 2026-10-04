-- Top 10 Revenue Generating Products
SELECT
oi.product_id,
ROUND(SUM(oi.price),2) AS Revenue
FROM order_items oi
GROUP BY oi.product_id
ORDER BY Revenue DESC
LIMIT 10;

-- Top 10 Selling Products
SELECT
oi.product_id,
ROUND(SUM(oi.price),2) AS Revenue
FROM order_items oi
GROUP BY oi.product_id
ORDER BY Revenue DESC
LIMIT 10;

-- Revenue by Product Category
SELECT
ct.product_category_name_english,
ROUND(SUM(oi.price),2) AS Revenue
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY ct.product_category_name_english
ORDER BY Revenue DESC;

-- Average Product Price by Category
SELECT
ct.product_category_name_english,
ROUND(AVG(oi.price),2) AS Avg_Price
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY ct.product_category_name_english
ORDER BY Avg_Price DESC;

-- Highest Freight Products
SELECT
product_id,
ROUND(AVG(freight_value),2) AS Avg_Freight
FROM order_items
GROUP BY product_id
ORDER BY Avg_Freight DESC
LIMIT 20;

-- Product Rating
SELECT
oi.product_id,
ROUND(AVG(r.review_score),2) Rating
FROM order_items oi
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY oi.product_id
ORDER BY Rating DESC;

-- vQ7. Heavy Products
SELECT
product_id,
product_weight_g
FROM products
ORDER BY product_weight_g DESC
LIMIT 20;
-- Q8. Largest Products
SELECT
product_id,
(product_length_cm*
product_width_cm*
product_height_cm)
AS Volume
FROM products
ORDER BY Volume DESC
LIMIT 20;
-- Q9. Category-wise Products
SELECT
ct.product_category_name_english,
COUNT(*) Total_Products
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY Total_Products DESC;

Q10. Products Never Sold
SELECT
product_id
FROM products
WHERE product_id NOT IN
(
SELECT DISTINCT product_id
FROM order_items
);
-- Q11. Average Weight by Category

SELECT
ct.product_category_name_english,
ROUND(AVG(product_weight_g),2)
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
GROUP BY ct.product_category_name_english;

-- Q12. Average Volume by Category
SELECT
ct.product_category_name_english,
ROUND(AVG(product_length_cm*
product_width_cm*
product_height_cm),2)
AS Avg_Volume
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
GROUP BY ct.product_category_name_english;

-- Q13. Price Distribution
SELECT

CASE

WHEN price<50 THEN 'Low'

WHEN price<200 THEN 'Medium'

ELSE 'High'

END Price_Band,

COUNT(*) Products

FROM order_items

GROUP BY Price_Band;

-- Q14. Product Revenue Contribution
SELECT
product_id,
ROUND(SUM(price),2) Revenue
FROM order_items
GROUP BY product_id
ORDER BY Revenue DESC;

-- Q15. Top Rated Categories
SELECT
ct.product_category_name_english,
ROUND(AVG(r.review_score),2) Rating
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY ct.product_category_name_english
ORDER BY Rating DESC;