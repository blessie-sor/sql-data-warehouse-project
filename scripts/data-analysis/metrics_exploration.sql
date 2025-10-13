/* 
Metrics Exploration
Purpose: To track product performance, measure key metrics (like total sales, total number of orders, etc.), and identify trends or patterns in sales data.
*/

-- Find the total sales
SELECT SUM(sales_amount) AS total_sales 
FROM gold.fact_sales

-- Find how many items are sold
SELECT SUM(quantity) AS total_items_sold 
FROM gold.fact_sales

-- Find the average selling price
SELECT AVG(price) AS avg_selling_price
FROM gold.fact_sales

-- Find the total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders -- use DISTINCT because a customer can order multiple products in a single order
FROM gold.fact_sales

-- Find the total number of products
SELECT COUNT(product_key) AS total_products
FROM gold.dim_products

-- Find the total number of customers
SELECT COUNT(customer_key) AS total_customers
FROM gold.dim_customers

-- Generate a report that shows all key metrics of the business
SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Quantity' as measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Average Price' as measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Number Orders' as measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Number Products' as measure_name, COUNT(DISTINCT product_key) AS measure_value FROM gold.dim_products
UNION ALL 
SELECT 'Total Number Customers' as measure_name, COUNT(DISTINCT customer_key) AS measure_value FROM gold.dim_customers
