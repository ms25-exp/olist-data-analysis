-- =========================================
-- 1. Row Count Validation
-- =========================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;

-- =========================================
-- 2. Duplicate Checks
-- =========================================
-- customers
SELECT customer_id, COUNT(*) AS cnt
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- orders
SELECT order_id, COUNT(*) AS cnt
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- sellers
SELECT seller_id, COUNT(*) AS cnt
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- products
SELECT product_id, COUNT(*) AS cnt
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- order_items
SELECT order_id, order_item_id, COUNT(*) AS cnt
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- payments
SELECT order_id, payment_sequential, COUNT(*) AS cnt
FROM payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

-- reviews
SELECT review_id, order_id, COUNT(*) AS cnt
FROM reviews
GROUP BY review_id, order_id
HAVING COUNT(*) > 1;

-- =========================================
-- 3. Null checks for important key columns
-- =========================================

SELECT 'customers.customer_id' AS column_name, COUNT(*) AS null_count
FROM customers
WHERE customer_id IS NULL

UNION ALL

SELECT 'orders.order_id', COUNT(*)
FROM orders
WHERE order_id IS NULL

UNION ALL

SELECT 'orders.customer_id', COUNT(*)
FROM orders
WHERE customer_id IS NULL

UNION ALL

SELECT 'order_items.order_id', COUNT(*)
FROM order_items
WHERE order_id IS NULL

UNION ALL

SELECT 'order_items.product_id', COUNT(*)
FROM order_items
WHERE product_id IS NULL

UNION ALL

SELECT 'payments.order_id', COUNT(*)
FROM payments
WHERE order_id IS NULL

UNION ALL

SELECT 'reviews.review_id', COUNT(*)
FROM reviews
WHERE review_id IS NULL

UNION ALL

SELECT 'reviews.order_id', COUNT(*)
FROM reviews
WHERE order_id IS NULL;

-- =========================================
-- 4. Orders datetime sanity check
-- =========================================
SELECT COUNT(*) AS missing_purchase_timestamp
FROM orders
WHERE order_purchase_timestamp IS NULL;

SELECT COUNT(*) AS invalid_approved_before_purchase
FROM orders
WHERE order_approved_at IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
  AND order_approved_at < order_purchase_timestamp;
  
SELECT COUNT(*) AS invalid_delivered_before_purchase
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
  AND order_delivered_customer_date < order_purchase_timestamp;