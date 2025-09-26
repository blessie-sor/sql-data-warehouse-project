/* 
Quality Checks in Silver Layer
	This script performs different quality checks to ensure data consistency, integrity, and process reliability in the silver tables.
	It includes checks for:
	- Null Checks (required fields are not null)
	- Data Format Validation (dates are valid and are in expected format)
	- Range Checks (dates fall within business range)
	- Uniqueness Checks (primary keys are unique)
	- Business Rule Checks (nulls, negative, and zero values are not allowed for certain columns)

Note: 
	This script should be executed after the Silver Layer has been loaded.
*/


-- 1. Check table silver.crm_cust_info
-- Check for nulls or duplicates in primary key
SELECT 
cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Check for consistency  
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;


-- 2. Check table silver.crm_prd_info
-- Check for nulls or duplicates in primary key
SELECT 
prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for nulls or negative numbers 
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Check for invalid order dates 
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

	
-- 3. Check table silver.crm_sales_details
-- Check for invalid order dates (order date > ship/due dates)
SELECT 
	sls_order_dt, 
	sls_ship_dt, 
	sls_due_dt
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
	OR sls_order_dt > sls_due_dt

-- Check for invalid order dates 
SELECT 
sls_due_dt 
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0 
	OR LEN(sls_due_dt) != 8  -- length has to be 8 -> YYYYMMDD
	OR sls_due_dt > 20501231 
	OR sls_due_dt < 19000101

-- Check for invalid values (negative, zero, null, incorrect sales calculation)
SELECT  
	sls_sales
	sls_quantity, 
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_price * sls_quantity
	OR sls_sales IS NULL 
	OR sls_quantity IS NULL 
	OR sls_price IS NULL 
	OR sls_sales <= 0 
	OR sls_quantity <= 0 
	OR sls_price <= 0 
ORDER BY sls_sales, sls_quantity, sls_price


-- 4. Check table silver.erp_cust_az12
-- Check for out of range dates	
SELECT bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE()

-- Check for consistency 
SELECT DISTINCT gen
FROM silver.erp_cust_az12


-- 5. Check table silver.erp_loc_a101
-- Check for consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101


-- 6. Check table silver.erp_px_cat_g1v2
-- Check for unwanted spaces
SELECT * FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
	OR subcat != TRIM(subcat) 
	OR maintenance != TRIM(maintenance)

-- Check for consistency 
SELECT DISTINCT maintenance 
FROM silver.erp_px_cat_g1v2



