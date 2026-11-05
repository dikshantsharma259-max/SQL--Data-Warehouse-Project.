/* 
==========================================================
THIS IS A STORED PROCEDURE
OBJECTIVE :
IT IS A PROCEDURE BY WHICH THE DATA IS CLEANED AND ORGANISED IN SILVER LAYER
IF THE TABLE IS ALREADY IN THE SERVER IT WILL BE REPALCED BY THE NEW ONE
+===========================================================
*/



EXEC silver.load_silver

CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN
DECLARE @Start_time DATETIME,@end_time DATETIME ,@batch_start_time DATETIME , @batch_end_time DATETIME;
BEGIN TRY
    SET @batch_start_time = GETDATE()
    PRINT '==================================='
    PRINT'LOADING CRM AHD ERP DATA'
    PRINT '==================================='
   
   PRINT 'LOADING silver.crm_Cust_info'
   SET @Start_time=GETDATE()
        TRUNCATE TABLE silver.crm_Cust_info
        INSERT INTO silver.crm_Cust_info(
        cst_id,cst_key,cst_firstname,cst_lastname,cst_gndr,cst_marital_status,cst_create_date)
        SELECT
        cst_id,
        cst_key,
        TRIM(cst_firstname),
        TRIM(CST_LASTNAME),
        CASE WHEN UPPER(cst_gndr) = 'F' THEN 'Female'
	        WHEN UPPER(cst_gndr) ='M' THEN 'Male'
	        ELSE 'N/A'
	        END	cst_gndr,
	        CASE WHEN UPPER(cst_marital_status) = 'S' THEN 'Single'
	        WHEN UPPER(cst_marital_status) ='M' THEN 'Married'
	        ELSE 'N/A'
	        END	cst_marital_status,
	        cst_create_date
	        FROM 
	        (
	        SELECT
	        *,ROW_NUMBER()OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC )as flag_star
	        FROM Bronze.crm_Cust_info
	        WHERE cst_id IS NOT NULL)t
	        WHERE flag_star = 1;
            SET @end_time = GETDATE()
    PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 
   SET @Start_time=GETDATE()
         TRUNCATE TABLE silver.crm_prod_info
         INSERT INTO silver.crm_prod_info
        (
            prd_id,
            cat_id,
            prd_key,
            prd_cost,
            prd_nm,
            prd_line,
            prd_start_dt,
            prd_end_dt
        )
        SELECT
            prd_id,
            REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
            SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
            ISNULL(prd_cost,0) AS prd_cost,     -- moved before prd_nm
            prd_nm,
            CASE
                WHEN TRIM(UPPER(prd_line)) = 'R' THEN 'ROAD'
                WHEN TRIM(UPPER(prd_line)) = 'M' THEN 'MOUNTAIN'
                WHEN TRIM(UPPER(prd_line)) = 'S' THEN 'OTHER SALE'
                WHEN TRIM(UPPER(prd_line)) = 'T' THEN 'TRACKS'
                ELSE 'N/A'
            END AS prd_line,
            CAST(prd_start_dt AS DATE),
            CAST(
                LEAD(prd_start_dt) OVER
                (PARTITION BY prd_key ORDER BY prd_start_dt) - 1
                AS DATE
            ) AS prd_end_dt
        FROM Bronze.crm_prod_info;
          SET @end_time = GETDATE()
           PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 
         SET @Start_time=GETDATE()
        TRUNCATE TABLE silver.crm_Sales_info
        INSERT INTO silver.crm_Sales_info(
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        sls_order_dt,
        sls_ship_dt,
        sls_due_dt,
        sls_sales,
        sls_quantity,
        sls_price
        )
        SELECT 
        sls_ord_num,
        sls_prd_key,
        sls_cust_id,
        CASE WHEN sls_order_dt<=0 OR LEN(SLS_ORDER_DT) !=8 THEN NULL
        ELSE CAST(CAST(sls_order_dt AS varchar) AS DATE)
        END sls_order_dt,
        CASE WHEN sls_ship_dt<=0 OR LEN(sls_ship_dt) !=8 THEN NULL
        ELSE CAST(CAST(sls_ship_dt AS varchar) AS DATE)
        END sls_ship_dt,
        CASE WHEN sls_due_dt<=0 OR LEN(sls_due_dt) !=8 THEN NULL
        ELSE CAST(CAST(sls_due_dt AS varchar) AS DATE)
        END sls_due_dt,
        CASE WHEN sls_sales != sls_quantity* ABS(SLS_PRICE) OR sls_sales IS NULL OR sls_sales <=0
        THEN sls_quantity * ABS(SLS_PRICE) 
        ELSE sls_sales
        END sls_sales,
        sls_quantity,
        CASE WHEN SLS_PRICE IS NULL OR sls_price<=0 OR sls_price != sls_sales/sls_quantity THEN
        sls_sales/sls_quantity
        ELSE sls_price
        END sls_price
        FROM Bronze.crm_Sales_info;
          SET @end_time = GETDATE()
          PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 
         SET @Start_time=GETDATE()
        TRUNCATE TABLE silver.erp_CUST_Personal_info
        INSERT INTO silver.erp_CUST_Personal_info(
        CID,BDATE,GEN)
        SELECT 
        CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
        END  CID,
        CASE WHEN BDATE > GETDATE() THEN NULL
        ELSE BDATE
        END BDATE,
        CASE WHEN UPPER(TRIM(GEN)) IN ('F','Female') THEN 'FEMALE'
        WHEN UPPER(TRIM(GEN)) IN ('M','Male') THEN 'MALE'
        ELSE 'N/A'
        END
        FROM Bronze.erp_CUST_Personal_info;
          SET @end_time = GETDATE()
           PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 
  SET @Start_time=GETDATE()
        TRUNCATE TABLE silver.erp_CUST_Country
        INSERT INTO silver.erp_CUST_Country (CID,CNTRY)
        SELECT 
        REPLACE(CID,'-','')CID,
        CASE WHEN TRIM(CNTRY) IN ('USA','United States','US') THEN 'United States'
        WHEN TRIM(CNTRY) ='' OR CNTRY IS NULL THEN 'NOT ASSIGNED'
        WHEN TRIM(CNTRY) IN ('DE') THEN 'Germany'
        ELSE TRIM(CNTRY)
        END AS CNTRY
        FROM Bronze.erp_CUST_Country;
          SET @end_time = GETDATE()
           PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 
        SET @Start_time=GETDATE()
        TRUNCATE TABLE silver.erp_PX_CAT
        INSERT INTO silver.erp_PX_CAT( 
        ID,CAT,SUBCAT,MAINTENANCE)
        SELECT 
        ID,
        CAT,
        SUBCAT,
        MAINTENANCE
        FROM Bronze.erp_PX_CAT
          SET @end_time = GETDATE() 
           PRINT'>>LOAD TIME:'+CAST(DATEDIFF(second,@Start_time,@end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 SET @batch_end_time = GETDATE()
 PRINT'>> TOTAL LOAD TIME:'+CAST(DATEDIFF(second,@batch_start_time,@batch_end_time)AS NVARCHAR)+'seconds'
       PRINT '==============='
 
END TRY
BEGIN CATCH
PRINT '-------------------'
PRINT 'ERROR OCCURED'
PRINT ERROR_MESSAGE()
PRINT '---------------------'
END CATCH
END
