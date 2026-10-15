– E-Commerce Sales Analytics
– Tools: MySQL, Pandas, Power BI

CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

– 1. Create table
CREATE TABLE IF NOT EXISTS ecommerce_sales_cleaned (
order_id INT PRIMARY KEY,
order_date DATE,
customer_id INT,
product_category VARCHAR(50),
region VARCHAR(30),
quantity INT,
unit_price DECIMAL(10,2),
discount DECIMAL(5,2),
payment_method VARCHAR(30),
delivery_days INT,
customer_rating DECIMAL(2,1),
revenue DECIMAL(12,2)
);

– 2. Check dataset
SELECT *
FROM ecommerce_sales_cleaned
LIMIT 10;

– 3. Overall business performance
SELECT
COUNT(*) AS total_orders,
COUNT(DISTINCT customer_id) AS total_customers,
SUM(quantity) AS total_units_sold,
ROUND(SUM(revenue), 2) AS total_revenue,
ROUND(AVG(revenue), 2) AS average_revenue_per_order
FROM ecommerce_sales_cleaned;

– 4. Monthly revenue trend
SELECT
DATE_FORMAT(order_date, ‘%Y-%m’) AS month,
COUNT(*) AS total_orders,
ROUND(SUM(revenue), 2) AS monthly_revenue
FROM ecommerce_sales_cleaned
GROUP BY DATE_FORMAT(order_date, ‘%Y-%m’)
ORDER BY month;

– 5. Sales by product category
SELECT
product_category,
COUNT(*) AS total_orders,
SUM(quantity) AS units_sold,
ROUND(SUM(revenue), 2) AS total_revenue
FROM ecommerce_sales_cleaned
GROUP BY product_category
ORDER BY total_revenue DESC;

– 6. Sales by region
SELECT
region,
COUNT(*) AS total_orders,
ROUND(SUM(revenue), 2) AS total_revenue
FROM ecommerce_sales_cleaned
GROUP BY region
ORDER BY total_revenue DESC;

– 7. Customer purchase analysis
SELECT
customer_id,
COUNT(*) AS total_orders,
ROUND(SUM(revenue), 2) AS total_spent
FROM ecommerce_sales_cleaned
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

– 8. Payment method analysis
SELECT
payment_method,
COUNT(*) AS total_orders,
ROUND(SUM(revenue), 2) AS total_revenue
FROM ecommerce_sales_cleaned
GROUP BY payment_method
ORDER BY total_revenue DESC;

– 9. Customer satisfaction by category
SELECT
product_category,
ROUND(AVG(customer_rating), 2) AS average_rating,
COUNT(*) AS total_orders
FROM ecommerce_sales_cleaned
GROUP BY product_category
ORDER BY average_rating DESC;

– 10. Delivery performance
SELECT
CASE
WHEN delivery_days <= 3 THEN ‘Fast (0-3 days)’
WHEN delivery_days <= 7 THEN ‘Standard (4-7 days)’
ELSE ‘Slow (8+ days)’
END AS delivery_category,
COUNT(*) AS total_orders,
ROUND(AVG(customer_rating), 2) AS average_rating
FROM ecommerce_sales_cleaned
GROUP BY delivery_category
ORDER BY average_rating DESC;

– 11. Discount analysis
SELECT
CASE
WHEN discount < 0.10 THEN ‘Low Discount (<10%)’
WHEN discount < 0.25 THEN ‘Medium Discount (10-24%)’
ELSE ‘High Discount (25%+)’
END AS discount_category,
COUNT(*) AS total_orders,
ROUND(AVG(revenue), 2) AS average_order_revenue,
ROUND(AVG(customer_rating), 2) AS average_rating
FROM ecommerce_sales_cleaned
GROUP BY discount_category
ORDER BY average_order_revenue DESC;
