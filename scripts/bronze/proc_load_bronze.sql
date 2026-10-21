
/*
========================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=======================================================
Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;
========================================================

*/







create or alter procedure bronze.bronze_load As

 DECLARE @START_DATE DATETIME , @END_DATE DATETIME , @BATCH_START_TIME DATETIME , @BATCH_END_TIME DATETIME ;
begin
BEGIN TRY 
SET @BATCH_START_TIME = GETDATE();
print ' loading bronze layer is start :';
PRINT'INSERTING THE DATA INTO bronze.crm_cust_info ';

SET @START_DATE = GETDATE() ;
truncate table bronze.crm_cust_info ;
bulk insert  bronze.crm_cust_info 
from 'C:\Users\hp\Desktop\DW_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
 firstrow = 2 ,
 FIELDTERMINATOR = ',',
 TABLock
)
SET @END_DATE = GETDATE() ; 

PRINT 'LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_DATE , @END_DATE) AS NVARCHAR ) + 'SECONDS';

PRINT'------------------';

PRINT'INSERTING THE DATA INTO bronze.crm_prd_info ';
SET @START_DATE = GETDATE() ; 
TRUNCATE TABLE bronze.crm_prd_info ;
bulk insert bronze.crm_prd_info 
from 'C:\Users\hp\Desktop\DW_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with
(
 firstrow = 2,
 fieldterminator = ',',
 TABLOCK
)

SET @END_DATE = GETDATE() ; 

PRINT 'LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_DATE , @END_DATE) AS NVARCHAR ) + 'SECONDS';

PRINT'------------------';

PRINT'INSERTING THE DATA INTO bronze.crm_sales_details ';
SET @START_DATE = GETDATE() ; 
TRUNCATE TABLE bronze.crm_sales_details ;
bulk insert bronze.crm_sales_details 
from 'C:\Users\hp\Desktop\DW_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with
(
 firstrow = 2,
 fieldterminator = ',',
 TABLOCK
)

SET @END_DATE = GETDATE() ; 

PRINT 'LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_DATE , @END_DATE) AS NVARCHAR ) + 'SECONDS';

PRINT'------------------';



PRINT'INSERTING THE DATA INTO bronze.erp_cust_az12 ';
SET @START_DATE = GETDATE() ; 
TRUNCATE TABLE bronze.erp_cust_az12 ;
bulk insert bronze.erp_cust_az12 
from 'C:\Users\hp\Desktop\DW_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with
(
 firstrow = 2,
 fieldterminator = ',',
 TABLOCK
)

SET @END_DATE = GETDATE() ; 

PRINT 'LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_DATE , @END_DATE) AS NVARCHAR ) + 'SECONDS';

PRINT'------------------';


PRINT'INSERTING THE DATA INTO bronze.erp_loc_a101 ';
SET @START_DATE = GETDATE() ; 
TRUNCATE TABLE bronze.erp_loc_a101 ;
bulk insert bronze.erp_loc_a101 
from 'C:\Users\hp\Desktop\DW_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with
(
 firstrow = 2,
 fieldterminator = ',',
 TABLOCK
)

SET @END_DATE = GETDATE() ; 

PRINT 'LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_DATE , @END_DATE) AS NVARCHAR ) + 'SECONDS';

PRINT'------------------';






PRINT'INSERTING THE DATA INTO bronze.erp_px_cat_g1v2';
SET @START_DATE = GETDATE() ; 

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2 
from 'C:\Users\hp\Desktop\DW_Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with
(
 firstrow = 2,
 fieldterminator = ',',
 TABLOCK
)

SET @END_DATE = GETDATE() ; 

PRINT 'LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_DATE , @END_DATE) AS NVARCHAR ) + 'SECONDS';

PRINT'------------------';
 SET @BATCH_END_TIME = GETDATE();
 PRINT'====================================================================';
 PRINT 'TOTOAL LOAD DURATION FOR THE BRONZE LAYER :' + CAST(DATEDIFF(SECOND , @BATCH_START_TIME , @BATCH_END_TIME) AS NVARCHAR ) + 'SECONDS';
 PRINT'====================================================================';
print 'loading bronze layer is finsh .';

END TRY 
 BEGIN CATCH
   PRINT '============================================'
   PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER .'
   PRINT ' ERROR MASAGE  IS : '+ ERROR_MESSAGE();
    PRINT ' ERROR NUMPER  IS : ' + CAST( ERROR_NUMBER() AS NVARCHAR) 
   PRINT '============================================'
 END CATCH 
end 


