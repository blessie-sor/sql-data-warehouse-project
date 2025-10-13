/* 
Dimensions Exploration
Purpose: To explore the structure of the dimension tables.
*/

-- Check countries where the customers are from to understand geographical distribution 
SELECT DISTINCT country
FROM gold.dim_customers

-- Check for unique categories, subcategories, and products
SELECT DISTINCT category
FROM gold.dim_products

SELECT DISTINCT category, subcategory
FROM gold.dim_products

SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_products
ORDER BY 1,2,3
