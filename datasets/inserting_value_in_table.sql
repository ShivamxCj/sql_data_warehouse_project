/*                                                                                     |
                                                                                       |
This script inserts the values from csv files into sql tables                          |
Before inserting from csv file the table is being Truncated (emptied)                  |
Here once I used ALTER TABLE to change the data type of a column from DATE to VARCHAR  |
                                                                                       |
*/                                                                                     
---------------------------------------------------------------------------------------

USE DataWareHouse;
GO

TRUNCATE TABLE bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
--SELECT COUNT(*) as TotalNo FROM bronze.crm_cust_info

TRUNCATE TABLE bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
--SELECT * FROM bronze.crm_prd_info

----------
ALTER TABLE bronze.crm_sales_details
ALTER COLUMN sls_order_dt VARCHAR(50)

TRUNCATE TABLE bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
-- SELECT * FROM bronze.crm_sales_details
-------------------

TRUNCATE TABLE bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
-- SELECT * FROM bronze.erp_cust_az12

TRUNCATE TABLE bronze.erp_LOC_A101
BULK INSERT bronze.erp_LOC_A101
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH(
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
-- SELECT * FROM bronze.erp_LOC_A101

TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
    FIRSTROW=2,
    FIELDTERMINATOR=',',
    TABLOCK
)
-- SELECT * FROM bronze.erp_px_cat_g1v2
