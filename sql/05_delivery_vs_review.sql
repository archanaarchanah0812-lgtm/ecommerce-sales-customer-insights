SELECT
  CASE
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) <= 7 THEN '1) 0-7 days'
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) <= 14 THEN '2) 8-14 days'
    WHEN DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) <= 21 THEN '3) 15-21 days'
    ELSE '4) 22+ days'
  END AS delivery_time,
  COUNT(*) AS orders,
  ROUND(AVG(r.review_score), 2) AS avg_review
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_time
ORDER BY delivery_time;