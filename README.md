# Sales Analytics Data Warehouse (SQL Server)

## Overview
This project focuses on designing and implementing a modern **Data Warehouse** to consolidate sales data from multiple source systems into a single, analytics-ready platform.  
The solution transforms raw CSV data from operational systems into structured datasets that drive better **business decision-making** around customer behavior, product performance, and sales trends.

The warehouse follows a **Medallion Architecture (Bronze / Silver / Gold)** to ensure data quality, maintainability, and scalability.



## Business Problem
Sales data is distributed across multiple operational systems, making it difficult for business and analytics teams to:
- Trust reported metrics
- Analyze customer and product performance consistently
- Identify sales trends over time

This project addresses these challenges by integrating ERP and CRM data into a unified model designed for reporting and insights.



## Architecture Overview

### Data Sources
- **ERP System** (CSV files)
- **CRM System** (CSV files)

### Target Platform
- **SQL Server** (Data Warehouse)

### Architecture Pattern
- **Bronze Layer** – Raw data ingestion from CSV files  
- **Silver Layer** – Cleansed and standardized data with data quality rules applied  
- **Gold Layer** – Business-ready fact and dimension views implementing a **star schema** for analytics



## Data Modeling
The warehouse is designed using a dimensional modeling approach to support analytical queries efficiently.

- **Fact View**
  - Sales transactions
- **Dimension Views**
  - Customers
  - Products

The star schema design:
- Simplifies analytical queries
- Improves query performance
- Provides consistent metric definitions across reporting use cases



## Data Quality & Transformation
To ensure reliable analytics, the following data quality steps are applied:
- Handling missing and invalid values
- Deduplication of records
- Standardization of keys and formats
- Validation of referential integrity between fact and dimension data



## ETL Process
1. **Extract**
   - Import raw CSV data from ERP and CRM systems into the Bronze layer

2. **Transform**
   - Cleanse and standardize data in the Silver layer
   - Apply business rules and resolve data quality issues

3. **Load**
   - Populate analytics-ready fact and dimension views in the Gold layer



## Analytics & Reporting
The Gold layer supports SQL-based analytics for:

- **Customer Behavior**
- **Product Performance**
- **Sales Trends**



## Documentation
- Data model documentation
- Star schema design overview
- Table and column definitions
- Business metric descriptions



## Technologies Used
- SQL Server
- SQL (T-SQL)
- CSV-based data ingestion
- Dimensional modeling
- Medallion architecture
