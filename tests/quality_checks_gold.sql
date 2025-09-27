/*
Quality Checks: Gold Layer
  This script performs quality checks to ensure data integrity and consistency in the Gold Layer. 
  These checks ensure:
    - Uniqueness of surrogate keys in dimension tables
    - Referential integrity between fact and dimension tables
    - Validation of relationships in the data model

Usage:
  Run this script after creating the fact and dimension tables.
*/

-- Check gold.dim_customers

-- Check for duplicate Customer Key
SELECT customer_key, COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
WHERE COUNT(*) > 1;

-- Check gold.dim_products

-- check for duplicate Product Key
SELECT product_key, COUNT(*)
FROM gold.dim_products
GROUP BY product_key
WHERE COUNT(*) > 1;

-- Check gold.fact_sales

-- Check linking of fact and dimensions
SELECT * 
FROM gold.fact_sales AS s 
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = s.customer_key
LEFT JOIN gold.dim_products AS p
ON p.product_key = s.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL
