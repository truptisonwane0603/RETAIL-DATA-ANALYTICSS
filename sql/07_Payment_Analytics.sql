-- Q1 Revenue by Payment Type
SELECT
payment_type,
ROUND(SUM(payment_value),2)
Revenue
FROM order_payments
GROUP BY payment_type
ORDER BY Revenue DESC;
-- Q2 Payment Type Distribution
SELECT
payment_type,
COUNT(*) Payments
FROM order_payments
GROUP BY payment_type;
-- Q3 Average Payment
SELECT
payment_type,
ROUND(AVG(payment_value),2)
Avg_Payment
FROM order_payments
GROUP BY payment_type;
-- Q4 Installment Distribution
SELECT
payment_installments,
COUNT(*) Orders
FROM order_payments
GROUP BY payment_installments
ORDER BY payment_installments;
-- Q5 Average Installments
SELECT
ROUND(AVG(payment_installments),2)
FROM order_payments;
-- Q6 Highest Payment Orders
SELECT
order_id,
MAX(payment_value)
Payment
FROM order_payments
GROUP BY order_id
ORDER BY Payment DESC
LIMIT 20;
-- Q7 Monthly Revenue
SELECT
strftime('%Y-%m',o.order_purchase_timestamp)
Month,
ROUND(SUM(p.payment_value),2)
Revenue
FROM orders o
JOIN order_payments p
ON o.order_id=p.order_id
GROUP BY Month;
-- Q8 Credit Card Usage %
SELECT
ROUND(
100.0*
SUM(CASE WHEN payment_type='credit_card' THEN 1 ELSE 0 END)
/COUNT(*),2)
Credit_Card_Percentage
FROM order_payments;
-- Q9 Payment Value Distribution
SELECT

CASE

WHEN payment_value<100 THEN 'Low'

WHEN payment_value<500 THEN 'Medium'

ELSE 'High'

END Payment_Group,

COUNT(*)

FROM order_payments

GROUP BY Payment_Group;
-- Q10 Payment Method by State
SELECT
c.customer_state,
p.payment_type,
COUNT(*) Total
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_payments p
ON o.order_id=p.order_id
GROUP BY c.customer_state,p.payment_type;