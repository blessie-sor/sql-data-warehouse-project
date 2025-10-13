/*
Date Range Exploration
Purpose: To understand the boundaries of dates and the age demographics.
*/

-- Check boundaries of the order dates by determining the dates of the first and last orders and how many years of sales are available
SELECT 
	MIN(order_date) AS first_order_date,
	MAX (order_date) AS last_order_date,
	DATEDIFF(year, MIN(order_date), MAX (order_date)) order_range_years
FROM gold.fact_sales

-- Find the youngest and the oldest customer and get their ages
SELECT 
	MIN(birth_date) AS oldest_birth_date,
	DATEDIFF(year, MIN(birth_date), GETDATE()) AS oldest_age,
	MAX(birth_date) AS youngest_birth_date,
	DATEDIFF(year, MAX(birth_date), GETDATE()) AS youngest_age
FROM gold.dim_customers
