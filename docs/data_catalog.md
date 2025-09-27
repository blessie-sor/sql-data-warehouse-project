## Gold Layer Data Catalog

### Overview
This document provides a detailed catalog of the **Gold Layer** datasets, which are modeled using **fact and dimension views** to support reporting, analytics, and business intelligence use cases.

The Gold Layer contains **curated, cleaned, and joined data** from upstream layers (Bronze and Silver), and is organized into **semantic views** that follow a star schema.
Each entry includes metadata about the dataset, such as field names, data types, nullability, description, and sensitivity.

### Purpose
- Serve as a trusted source of business-ready data
- Improve usability and discoverability of key datasets

### Architecture

- Datasets are implemented as **views**, not physical tables
- Follows a **dimensional modeling** structure:
  - **Fact views** store measurable business events (e.g., sales, transactions)
  - **Dimension views** provide descriptive attributes (e.g., customer, product, date)
  
---

### Subject Area: Sales

#### View: gold.dim_customers

| Field Name       | Data Type    | Nullable | Description                                                                          | Example         | Sensitivity |
|------------------|--------------|----------|--------------------------------------------------------------------------------------|-----------------|-------------|
| `customer_key`   | INTEGER      | No       | Surrogate key uniquely identifying each customer record in the dimension table       | `13645`         | Low         |
| `customer_id`    | INTEGER      | No       | Unique identifier for each customer                                                  | `24644`         | Low         |
| `customer_number`| INTEGER      | No       | Alphanumeric identifier representing the customer, used for tracking and referencing | `AW00024644`    | Low         |
| `first_name`     | NVARCHAR(50) | No       | Customer's first name                                                                | `Jon`           | Medium      |
| `last_name`      | NVARCHAR(50) | No       | Customer's last name                                                                 | `Yang`          | Medium      |
| `country`        | NVARCHAR(50) | Yes      | Customer's country of residence                                                      | `Australia`     | Low         |
| `marital_status` | NVARCHAR(50) | Yes      | Customer's marital status                                                            | `Married`       | Medium      |
| `gender`         | NVARCHAR(50) | Yes      | Customer's gender                                                                    | `Male`          | Medium      |
| `birth_date`     | DATE         | Yes      | Customer's date of birth, formatted as YYYY-MM-DD                                    | `1971-10-06`    | High        |
| `create_date`    | DATE         | No       | Date when the customer's record was created in the system                            | `2025-10-06`    | Low         |

**Source(s):** silver.crm_cust_info, silver.erp_cust_az12, silver.erp_loc_a101
**Purpose:** Provides customer demographic and geographic data for sales. 


#### View: gold.fact_sales

| Field Name       | Data Type    | Nullable | Description                                                                          | Example         | Sensitivity |
|------------------|--------------|----------|--------------------------------------------------------------------------------------|-----------------|-------------|
| `order_number`   | NVARCHAR(50) | No       | Alphanumeric identifier for each sales order                                         | `SO64338`       | Low         |
| `product_key`    | INTEGER      | No       | Surrogate key linking the order to the product dimension table                       | `289`           | Low         |
| `customer_key`   | INTEGER      | No       | Surrogate key linking the order to the customer dimension table                      | `503`           | Low         |
| `order_date`     | DATE         | Yes      | Date when the order was placed                                                       | `2011-01-19`    | Low         |
| `shipping_date`  | DATE         | No       | Date when the order was shipped                                                      | `2011-01-26`    | Low         |
| `due_date`       | DATE         | No       | Date when the order payment was due                                                  | `2011-01-31`    | Low         |
| `sales_amount`   | INTEGER      | No       | Total value of the sale for the line item, in whole currency units                   | `3375`          | Medium      |
| `quantity`       | INTEGER      | No       | Number of units of the product ordered for the line item                             | `1`             | Low         |
| `price`          | INTEGER      | No       | Price per unit of the product for the line item, in whole currency units             | `3375`          | Medium      |

**Source(s):** silver.crm_sales_details, silver.crm_prd_info, silver.crm_cust_info
**Purpose:** Provides detailed sales transaction data for revenue analysis and reporting. 



### Subject Area: Product

#### View: gold.dim_products

| Field Name       | Data Type    | Nullable | Description                                                                          | Example         | Sensitivity |
|------------------|--------------|----------|--------------------------------------------------------------------------------------|-----------------|-------------|
| `product_key`    | INTEGER      | No       | Surrogate key uniquely identifying each product record in the product dimension table| `127`           | Low         |
| `product_id`     | INTEGER      | No       | Unique identifer assigned to the product for internal tracking and referencing       | `605`           | Low         |
| `product_number` | NVARCHAR(50) | No       | Alphanumeric code representing the product, used for categorization                  | `CA-1098`       | Low         |
| `product_name`   | NVARCHAR(50) | No       | Name of the product, including details such as size, type, and color                 | `AWC Logo Cap`  | Low         |
| `category_id`    | NVARCHAR(50) | Yes      | Unique identifier for the product's category, a high-level classification            | `CL_CA`         | Low         |
| `category`       | NVARCHAR(50) | Yes      | Broader classification of the product                                                | `Clothing`      | Low         |
| `subcategory`    | NVARCHAR(50) | Yes      | Detailed classification of the product within the category                           | `Caps`          | Medium      |
| `maintenance`    | NVARCHAR(50) | Yes      | Indicates whether the product requires maintenance                                   | `Yes`           | Low         |
| `cost`           | INTEGER      | No       | Cost or the base price of the product, measured in monetary units                    | `7`             | Medium      |
| `product_line`   | NVARCHAR(50) | Yes      | Product line or series to which the product belongs                                  | `Other Sales`   | Low         |
| `start_date`     | DATE         | No       | Date when the product became available for sale or use                               | `2013-07-01`    | Medium      |

**Source(s):** silver.crm_prd_info, silver.erp_px_cat_g1v2
**Purpose:** Provides detailed sales transaction data for revenue analysis and reporting. 




**Note:** Although stored as views, these datasets are treated as logical tables in the data model and should be used accordingly. Follow data privacy and access control policies when working with sensitive fields.
