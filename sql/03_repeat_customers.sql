 

WITH cust AS (
  SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS orders
  FROM olist_ecommerce.orders o
  JOIN olist_ecommerce.customers c ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  COUNT(*) AS total_customers,
  SUM(orders > 1) AS repeat_customers,
  ROUND(100 * SUM(orders > 1) / COUNT(*), 2) AS repeat_pct
FROM cust;


