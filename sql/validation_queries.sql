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
  
-- =========================================
-- 5. Reviews business validation
-- =========================================
  
SELECT review_score, COUNT(*) AS cnt
FROM reviews
GROUP BY review_score
ORDER BY review_score;

SELECT COUNT(*) AS invalid_review_scores
FROM reviews
WHERE review_score NOT BETWEEN 1 AND 5
   OR review_score IS NULL;
 
-- ========================
-- Blank comments are valid
-- ========================
SELECT
    SUM(CASE WHEN review_comment_title IS NULL OR TRIM(review_comment_title) = '' THEN 1 ELSE 0 END) AS blank_title_count,
    SUM(CASE WHEN review_comment_message IS NULL OR TRIM(review_comment_message) = '' THEN 1 ELSE 0 END) AS blank_message_count
FROM reviews;

-- =========================================
-- 6. Payments validation
-- =========================================
-- Negative or zero payment values
SELECT COUNT(*) AS non_positive_payment_rows
FROM payments
WHERE payment_value IS NULL OR payment_value <= 0;

-- Installments sanity
SELECT payment_installments, COUNT(*) AS cnt
FROM payments
GROUP BY payment_installments
ORDER BY payment_installments;

-- ============================
-- 7. Order items validation
-- ============================
-- Negative or zero price/freight
SELECT COUNT(*) AS invalid_price_rows
FROM order_items
WHERE price IS NULL OR price < 0;

SELECT COUNT(*) AS invalid_freight_rows
FROM order_items
WHERE freight_value IS NULL OR freight_value < 0;


-- =========================================
-- 8. Business Validation for Dashboard Readiness
-- =========================================

-- 8.1 Order Grain Validation
-- Check whether each row in orders represents a unique order_id
SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;


-- 8.2 Revenue Totals Sanity
-- Compare total payment value and total order item value
-- These may not be exactly equal, but should be logically reasonable
SELECT 
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM payments;

SELECT 
    ROUND(SUM(price + freight_value), 2) AS total_order_item_value
FROM order_items;


-- 8.3 Orders Without Payment
-- Identify orders that do not have any payment record
SELECT 
    COUNT(DISTINCT o.order_id) AS orders_without_payment
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
WHERE p.order_id IS NULL;


-- 8.4 Orders Without Review
-- Identify orders that do not have any review record
SELECT 
    COUNT(DISTINCT o.order_id) AS orders_without_review
FROM orders o
LEFT JOIN reviews r
    ON o.order_id = r.order_id
WHERE r.order_id IS NULL;


-- 8.5 Delivered Orders Missing Delivery Date
-- Delivered orders should ideally have a delivered customer date
SELECT 
    COUNT(*) AS delivered_orders_missing_delivery_date
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;


-- 8.6 Delayed Orders
-- Delivered orders where actual delivery date is later than estimated delivery date
SELECT 
    COUNT(*) AS delayed_orders
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
  AND order_delivered_customer_date > order_estimated_delivery_date;


-- 8.7 Category Translation Coverage
-- Check how many product categories do not have English translation mapping
SELECT 
    COUNT(*) AS products_without_category_translation
FROM products p
LEFT JOIN categories c
    ON p.product_category_name = c.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND c.product_category_name IS NULL;
  
-- 8.7.1 Unmapped Category Impact Check
-- Identifies untranslated product categories and measures their order and sales impact
SELECT 
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN categories c
    ON p.product_category_name = c.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND c.product_category_name IS NULL
GROUP BY p.product_category_name
ORDER BY total_sales DESC;

-- Note:
-- Missing category translations were found for a small number of categories.
-- These categories will be retained in reporting and handled in Power BI using fallback or manual mapping logic.


-- 8.8 Monthly Order Trend Source Check
-- Validate whether monthly order volume looks ready for dashboarding
SELECT 
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY 
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY 
    order_year,
    order_month;


-- 8.9 Monthly Revenue Trend Source Check
-- Validate whether monthly revenue trend is ready for dashboarding
SELECT 
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY 
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)
ORDER BY 
    order_year,
    order_month;
