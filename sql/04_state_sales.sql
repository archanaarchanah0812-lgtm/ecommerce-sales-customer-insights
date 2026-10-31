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