-- Q1 Average Review Score
SELECT
ROUND(AVG(review_score),2)
FROM order_reviews;
-- Q2 Rating Distribution
SELECT
review_score,
COUNT(*) Reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;
-- Q3 Positive Review %
SELECT
ROUND(
100.0*
SUM(CASE WHEN review_score>=4 THEN 1 ELSE 0 END)
/COUNT(*),2)
Positive_Percentage
FROM order_reviews;
-- Q4 Negative Review %
SELECT
ROUND(
100.0*
SUM(CASE WHEN review_score<=2 THEN 1 ELSE 0 END)
/COUNT(*),2)
Negative_Percentage
FROM order_reviews;
-- Q5 Review by Product Category
SELECT
ct.product_category_name_english,
ROUND(AVG(r.review_score),2)
Rating
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY ct.product_category_name_english
ORDER BY Rating DESC;
-- Q6 Seller Ratings
SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2)
Rating
FROM order_items oi
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY seller_id
ORDER BY Rating DESC;
-- Q7 Review by State
SELECT
c.customer_state,
ROUND(AVG(r.review_score),2)
Rating
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_reviews r
ON o.order_id=r.order_id
GROUP BY customer_state;
-- Q8 Review vs Delivery Days
SELECT
ROUND(
AVG(
JULIANDAY(o.order_delivered_customer_date)-JULIANDAY(o.order_purchase_timestamp)
),2)
Delivery_Days,
ROUND(AVG(r.review_score),2)
Rating
FROM orders o
JOIN order_reviews r
ON o.order_id=r.order_id;
-- Q9 Monthly Review Trend
SELECT
strftime('%Y-%m',review_creation_date)
Month,
ROUND(AVG(review_score),2)
Rating
FROM order_reviews
GROUP BY Month;
Q10 Orders Without Reviews
SELECT
COUNT(*)
FROM orders o
LEFT JOIN order_reviews r
ON o.order_id=r.order_id
WHERE r.review_id IS NULL;
-- Q11 Five-Star Reviews by Category
SELECT
ct.product_category_name_english,
COUNT(*) Five_Stars
FROM products p
JOIN category_translation ct
ON p.product_category_name=ct.product_category_name
JOIN order_items oi
ON p.product_id=oi.product_id
JOIN order_reviews r
ON oi.order_id=r.order_id
WHERE r.review_score=5
GROUP BY ct.product_category_name_english
ORDER BY Five_Stars DESC;
-- Q12 Lowest Rated Products
SELECT
oi.product_id,
ROUND(AVG(r.review_score),2) Rating
FROM order_items oi
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY oi.product_id
HAVING COUNT(r.review_id)>=10
ORDER BY Rating
LIMIT 20;
-- Q13 Highest Rated Sellers
SELECT
oi.seller_id,
ROUND(AVG(r.review_score),2) Rating
FROM order_items oi
JOIN order_reviews r
ON oi.order_id=r.order_id
GROUP BY oi.seller_id
HAVING COUNT(r.review_id)>=20
ORDER BY Rating DESC;
-- Q14 Review Score by Payment Type
SELECT
p.payment_type,
ROUND(AVG(r.review_score),2)
Rating
FROM order_payments p
JOIN order_reviews r
ON p.order_id=r.order_id
GROUP BY p.payment_type;
-- Q15 Review Comments Availability
SELECT
CASE
WHEN review_comment_message IS NULL
OR TRIM(review_comment_message)=''
THEN 'No Comment'
ELSE 'Comment Available'
END Comment_Status,
COUNT(*) Reviews
FROM order_reviews
GROUP BY Comment_Status;