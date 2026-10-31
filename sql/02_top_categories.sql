SELECT
  COALESCE(ct.product_category_name_english, 'unknown') AS category,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN olist_ecommerce.products p ON oi.product_id = p.product_id
LEFT JOIN olist_ecommerce.category_translation ct
  ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;


SELECT
  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
  ROUND(SUM(oi.price), 2) AS revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY revenue DESC
LIMIT 1;

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


SELECT
  c.customer_state AS state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.customers c ON o.customer_id = c.customer_id
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY state
ORDER BY revenue DESC
LIMIT 10;

SELECT
  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
  ROUND(SUM(oi.price), 2) AS revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY revenue DESC
LIMIT 1;