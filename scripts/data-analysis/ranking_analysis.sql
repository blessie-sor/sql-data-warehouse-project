/*
Ranking Analysis
Purpose: To identify top-performing products and high-value customers and pinpoint underperforming products to improve sales strategies.
*/

-- Find the top 5 products that generate the highest revenue using GROUP BY and TOP
SELECT TOP 5 p.product_id, p.product_name, SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p ON s.product_key = p.product_key
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC

-- Find the top 5 products that generate the highest revenue using Window Function & GROUP BY
SELECT * 
FROM (
	SELECT p.product_name, SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER () OVER (ORDER BY SUM(s.sales_amount) DESC) AS rn
	FROM gold.fact_sales AS s
	LEFT JOIN gold.dim_products AS p ON s.product_key = p.product_key
	GROUP BY p.product_name
)t
WHERE rn <= 5

-- Find the top 5 worst-performing products based on sales
SELECT TOP 5 p.product_id, p.product_name, SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p ON s.product_key = p.product_key
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue 

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10 
	c.customer_id, 
	c.first_name, 
	c.last_name, 
	SUM(s.sales_amount) total_revenue_per_customer
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c ON s.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue_per_customer DESC

-- Find the top 3 customers with the fewest orders placed
SELECT TOP 3 
	c.customer_id, 
	c.first_name, 
	c.last_name, 
	COUNT(DISTINCT s.order_number) total_orders
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c ON s.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders 
