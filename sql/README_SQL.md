## KPI 1: Total Revenue
**Query:** `01_Executive_KPIs.sql`

**Interview Question:** Why use `SUM(price)` instead of `SUM(payment_value)`?
**Answer:** Revenue comes from the actual selling price of each order item. If we used payment value, we might accidentally include freight costs or miscalculate based on installments.