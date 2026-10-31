SELECT
  COALESCE(ct.product_category_name_english, 'unknown') AS category,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(AVG(r.review_score), 2) AS avg_review
FROM olist_ecommerce.orders o
JOIN olist_ecommerce.order_items oi ON o.order_id = oi.order_id
JOIN olist_ecommerce.products p ON oi.product_id = p.product_id
LEFT JOIN olist_ecommerce.category_translation ct
  ON p.product_category_name = ct.product_category_name
JOIN olist_ecommerce.order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
HAVING orders >= 100
ORDER BY avg_review ASC
LIMIT 5;