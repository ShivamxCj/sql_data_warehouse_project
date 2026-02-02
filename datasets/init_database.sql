/* ----Creating Database and Schemas----- 
This script checks if the database named 'DataWareHouse' already exists or not, if it exists then it drops the existing database and creates a new database named as 
DataWareHouse. Additionally it creates three schemas named 'bronze', 'silver' and 'gold'
*/

--checks if database already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWareHouse')
BEGIN
    ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWareHouse
END;
go

--creating the database
CREATE DATABASE DataWareHouse;
go

USE DataWareHouse;
go

--creating the schemas
CREATE SCHEMA bronze;
go

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
go

