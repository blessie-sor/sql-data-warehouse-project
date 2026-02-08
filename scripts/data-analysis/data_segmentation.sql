/* 
Data Segmentation Analysis
Purpose: To divide customers, products into groups based on shared characteristics to target personalized insights and understand their correlation. 
*/

-- Segment products into cost ranges and count how many products fall under each category
WITH product_segment AS (
SELECT
	product_key,
	product_name,
	cost,
	CASE WHEN cost < 100 THEN 'Below 100' 
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM gold.dim_products
)

SELECT cost_range, COUNT(product_key) AS total_product
FROM product_segment 
GROUP BY cost_range
ORDER BY total_product DESC

/* Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending of more than 5,000.
	- Regular: Customers with at least 12 months of history but spending 5,000 or less,
	- New: Customers with a lifespan of less than 12 months.
And find the total number of customers per each group.
*/
  
WITH customer_spending AS (
SELECT 
	c.customer_key,
	SUM(s.sales_amount) AS total_spend,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan_month
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c ON c.customer_key = s.customer_key
GROUP BY c.customer_key
)

SELECT 
	customer_segment, COUNT(customer_key) AS total_customers
FROM (
	SELECT 
	 		customer_key,
		CASE WHEN lifespan_month >= 12 AND total_spend > 5000 THEN 'VIP'
			WHEN lifespan_month >= 12 AND total_spend <= 5000 THEN 'Regular'
			ELSE 'New'
		END customer_segment
	FROM customer_spending
)t 
GROUP BY customer_segment
ORDER BY total_customers DESC
