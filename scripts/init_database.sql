/*
Create Database and Schemas 
This script creates a new database named 'DataWarehouse' after checking if it already exists. If such database exists, 
it is dropped and recreated. This script also creates three schemas: 'bronze', 'silver', and 'gold'. 
*/

USE master;
GO

-- Drop and recreate database 'DataWarehouse' 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

-- Create database 'DataWarehouse'
CREATE DATABASE 'DataWarehouse';
GO 

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
