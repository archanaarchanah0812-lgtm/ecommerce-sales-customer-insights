SELECT
  DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.price), 2) AS revenue
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;