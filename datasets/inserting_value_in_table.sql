
/*                                                                                     |
                                                                                       |
This script inserts the values from csv files into sql tables  and making a            |
STORED PROCEDURE to load the bronze layer                                              |
                                                                                       | 
Before inserting from csv file the table is being Truncated (emptied)                  |
                                                                                       |
PRINT is used to display messages                                                      |
                                                                                       |
i also used TRY CATCH for error handling                                               |
                                                                                       |
declared variables and used GETDATE() and DATEDIFF() to calculate the duration of      |
different process and total duration of loading the layer                              |
Here once I used ALTER TABLE to change the data type of a column from DATE to VARCHAR  | 
                                                                                       |
*/                                                                                     
---------------------------------------------------------------------------------------

USE DataWareHouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

BEGIN TRY
DECLARE @start DATETIME, @end DATETIME, @layer_start DATETIME, @layer_end DATETIME
SET @layer_start = GETDATE()

PRINT '======================='
PRINT 'Loading BRONZE Layer'
PRINT '======================='

PRINT '-----------------------'
PRINT 'Loading crm data'
PRINT '-----------------------'
-- ------------------------------------------------------------------------------------ 
SET @start= GETDATE()
PRINT '>>Truncating Table: bronze.crm_cust_info'
TRUNCATE TABLE bronze.crm_cust_info
PRINT '>>Inserting Data into: bronze.crm_cust_info'
BULK INSERT bronze.crm_cust_info
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
--SELECT COUNT(*) as TotalNo FROM bronze.crm_cust_info
SET @end=GETDATE()
PRINT 'time taken:'+ CAST(DATEDIFF(second, @start,@end) AS NVARCHAR)+'seconds'
-- ------------------------------------------------------------------------------------ 

-- ------------------------------------------------------------------------------------ 
SET @start= GETDATE()
PRINT '>>Truncating Table: bronze.crm_prd_info'
TRUNCATE TABLE bronze.crm_prd_info
PRINT '>>Inserting Data into: bronze.crm_prd_info'
BULK INSERT bronze.crm_prd_info
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
--SELECT * FROM bronze.crm_prd_info
SET @end=GETDATE()
PRINT 'time taken:'+ CAST(DATEDIFF(second, @start,@end) AS NVARCHAR)+'seconds'
-- ------------------------------------------------------------------------------------ 

-- ------------------------------------------------------------------------------------ 
SET @start= GETDATE()
ALTER TABLE bronze.crm_sales_details
ALTER COLUMN sls_order_dt VARCHAR(50)
PRINT '>>Truncating Table: bronze.crm_sales_details'
TRUNCATE TABLE bronze.crm_sales_details
PRINT '>>Inserting Data into: bronze.crm_sales_details'
BULK INSERT bronze.crm_sales_details
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
-- SELECT * FROM bronze.crm_sales_details
SET @end=GETDATE()
PRINT 'time taken:'+ CAST(DATEDIFF(second, @start,@end) AS NVARCHAR)+'seconds'
-- ------------------------------------------------------------------------------------ 

PRINT '-----------------------'
PRINT 'Loading erp Data'
PRINT '-----------------------'

-- ------------------------------------------------------------------------------------ 
SET @start= GETDATE()
PRINT '>>Truncating Table: bronze.erp_cust_az12'
TRUNCATE TABLE bronze.erp_cust_az12
PRINT '>>Inserting Data into: bronze.erp_cust_az12'
BULK INSERT bronze.erp_cust_az12
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW= 2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
-- SELECT * FROM bronze.erp_cust_az12
SET @end=GETDATE()
PRINT 'time taken:'+ CAST(DATEDIFF(second, @start,@end) AS NVARCHAR)+'seconds'
-- ------------------------------------------------------------------------------------ 

-- ------------------------------------------------------------------------------------ 
SET @start= GETDATE()
PRINT '>>Truncating Table: bronze.erp_LOC_A101'
TRUNCATE TABLE bronze.erp_LOC_A101
PRINT '>>Inserting Data into: bronze.erp_LOC_A101'
BULK INSERT bronze.erp_LOC_A101
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH(
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    TABLOCK
)
-- SELECT * FROM bronze.erp_LOC_A101
SET @end=GETDATE()
PRINT 'time taken:'+ CAST(DATEDIFF(second, @start,@end) AS NVARCHAR)+'seconds'
-- ------------------------------------------------------------------------------------ 

-- ------------------------------------------------------------------------------------ 
SET @start= GETDATE()
PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2'
TRUNCATE TABLE bronze.erp_px_cat_g1v2
PRINT '>>Inserting Data into: bronze.erp_px_cat_g1v2'
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'D:\data warehousing\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
    FIRSTROW=2,
    FIELDTERMINATOR=',',
    TABLOCK
);
-- SELECT * FROM bronze.erp_px_cat_g1v2
SET @end=GETDATE()
PRINT 'time taken:'+ CAST(DATEDIFF(second, @start,@end) AS NVARCHAR)+'seconds'
-- ------------------------------------------------------------------------------------ 
SET @layer_end= GETDATE()
PRINT '=================================='
PRINT 'Bronze Layer Loaded Sucessfuly!'
PRINT 'Total duration to load BRONZE Layer:' + CAST(DATEDIFF(second, @layer_start,@layer_end) AS NVARCHAR)+' seconds'
PRINT '=================================='


END TRY

BEGIN CATCH
    PRINT 'ERROR LOADING BRONZE LAYER!!!'
    PRINT ' ERROR MESSAGE:'+ ERROR_MESSAGE();
    PRINT ' ERROR NUMBER:'+ CAST (ERROR_NUMBER() AS NVARCHAR)
END CATCH

END
