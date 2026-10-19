/*==================
THIS IS A STORED PROCEDURE FOR BULK INSERTING DATA IN THE SCHEMAS
======================*/
/*PURPOSE :THIS HELP TO GET OR PUSH THE DATE IN THE SCHEMAS IN BULK FOR FURTHER ANALYSIS
-SCRIPT IS GOING TO FIRST TRUNCATE THE WHOLE DATA INSIDE AND GET THE NEW DATA

USAGE : EXEC  Bronze.load_Bronze
=======================*/


/*STORED PROCEDURE*/
CREATE OR ALTER PROCEDURE Bronze.load_Bronze AS
BEGIN
DECLARE @Start_time DATETIME,@end_time DATETIME

SET @Start_time=GETDATE()
TRUNCATE TABLE Bronze.crm_Cust_info;
BULK INSERT Bronze.crm_Cust_info
FROM 'C:\Users\diksh\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);SET @end_time=GETDATE()
PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
PRINT'=============='

SET @Start_time=GETDATE()
TRUNCATE TABLE Bronze.crm_prod_info;
BULK INSERT Bronze.crm_prod_info
FROM 'C:\Users\diksh\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);SET @end_time=GETDATE()
PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
PRINT'=============='

SET @Start_time=GETDATE()
TRUNCATE TABLE Bronze.crm_sales_info;
BULK INSERT Bronze.crm_sales_info
FROM 'C:\Users\diksh\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);SET @end_time=GETDATE()
PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
PRINT'=============='


SET @Start_time=GETDATE()
TRUNCATE TABLE Bronze.erp_CUST_Personal_info;
BULK INSERT Bronze.erp_CUST_Personal_info
FROM 'C:\Users\diksh\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);SET @end_time=GETDATE()
PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
PRINT'=============='

SET @Start_time=GETDATE()
TRUNCATE TABLE Bronze.erp_CUST_Country;
BULK INSERT Bronze.erp_CUST_Country
FROM 'C:\Users\diksh\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);SET @end_time=GETDATE()
PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
PRINT'=============='


SET @Start_time=GETDATE()
TRUNCATE TABLE Bronze.erp_PX_CAT;
BULK INSERT Bronze.erp_PX_CAT
FROM 'C:\Users\diksh\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);SET @end_time=GETDATE()
PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
PRINT'=============='
END
