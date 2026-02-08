/* 
Performance Analysis
Purpose: To help evaluate success by comparing the performance of products and customers against goals and track improvements. 
*/

-- Analyze the yearly performance of products by comparing each product’s sales to both its average sales performance and the previous year’s sales

WITH yearly_product_sales AS (
SELECT 
	YEAR(s.order_date) AS order_year, 
	p.product_name,
	SUM(s.sales_amount) AS current_sales
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p ON p.product_key = s.product_key
WHERE s.order_date IS NOT NULL
GROUP BY YEAR(s.order_date), p.product_name
)

SELECT 
  order_year,
  product_name,
  current_sales,
  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year_sales, -- year over year
  current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS difference_previous_year,
  CASE 
    WHEN current_sales -  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase' 
	  WHEN current_sales -  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
	  ELSE 'Same'
  END AS year_change,
  AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
  current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS difference, 
  CASE 
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg' 
	  WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
	  ELSE 'Avg'
  END AS avg_change
FROM yearly_product_sales
ORDER BY product_name, order_year
