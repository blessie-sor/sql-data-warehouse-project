/* 
Cumulative Analysis
Purpose: To track total accumulation of a metric over time, identify overall trends, and help understand how the business is doing.  
*/

-- Calculate the total sales each month and the running total of sales over time 
SELECT 
  order_date,
  total_sales,
  SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total_sales
FROM (
  SELECT 
    DATETRUNC(month, order_date) AS order_date, 
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t

-- Get the moving average price 
SELECT 
  order_date,
  total_sales,
  SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total_sales,
  AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM (
  SELECT 
    DATETRUNC(month, order_date) AS order_date, 
    SUM(sales_amount) AS total_sales, 
    AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t
