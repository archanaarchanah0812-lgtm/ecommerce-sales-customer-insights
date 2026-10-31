SELECT
  payment_type,
  COUNT(DISTINCT order_id) AS orders,
  ROUND(SUM(payment_value), 2) AS total_value,
  ROUND(100 * SUM(payment_value) / (SELECT SUM(payment_value) FROM olist_ecommerce.order_payments), 2) AS pct_value
FROM olist_ecommerce.order_payments
GROUP BY payment_type
ORDER BY total_value DESC;