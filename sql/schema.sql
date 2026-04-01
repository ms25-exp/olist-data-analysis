CREATE TABLE orders (
    order_id VARCHAR(255),
    customer_id VARCHAR(255),
    order_status VARCHAR(255),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_items (
    order_id VARCHAR(255),
    order_item_id INT,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE payments (
    order_id VARCHAR(255),
    payment_sequential INT,
    payment_type VARCHAR(255),
    payment_installments INT,
    payment_value DECIMAL(10,2),
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE reviews (
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

CREATE TABLE customers (
    customer_id VARCHAR(255),
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(255),
    customer_state VARCHAR(255),
    PRIMARY KEY (customer_id)
);

CREATE TABLE sellers (
    seller_id VARCHAR(255),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(255),
    seller_state VARCHAR(255),
    PRIMARY KEY (seller_id)
);

CREATE TABLE products (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_lenght DECIMAL(10,2),
    product_description_lenght DECIMAL(10,2),
    product_photos_qty DECIMAL(10,2),
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2),
    PRIMARY KEY (product_id)
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,2),
    geolocation_lng DECIMAL(10,2),
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(255)
);

CREATE TABLE categories (
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

