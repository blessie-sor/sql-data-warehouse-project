/* 
Part-To-Whole Analysis
Purpose: To understand which product category has the biggest impact on the business by analyzing its performance compared to overall product category performance. 
*/

-- Get category that holds the biggest impact on overall sales
WITH category_sales AS (
	SELECT 
		p.category,
		SUM(s.sales_amount) AS total_sales
	FROM gold.fact_sales AS s
	LEFT JOIN gold.dim_products AS p ON p.product_key = s.product_key
	GROUP BY p.category
	)

SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER () AS total_sales_cat,
	CONCAT( ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2), '%') AS percent_total
FROM category_sales
ORDER BY total_sales DESC
