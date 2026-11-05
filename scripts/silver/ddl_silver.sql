--==========================================================
  --DDL SCRIPT :FOR SILVER LAYER
--OBJECTIVE : MAKE TABLE FOR ALL THE CLEANED ORGANISED DATA
--INCLUDE ALL THE COLUMNS RELATED TO THE BRONZE LEVEL
--============================================================

IF OBJECT_ID('silver.crm_Cust_info','U') IS NOT NULL
	DROP  TABLE silver.crm_Cust_info;
CREATE TABLE silver.crm_Cust_info (
cst_id INT,cst_key NVARCHAR(50),
cst_firstname NVARCHAR(20),cst_lastname NVARCHAR(20),
cst_marital_status NVARCHAR(15),cst_gndr NVARCHAR(15)
,cst_create_date DATE
,dwh_create_date DATETIME2 DEFAULT GETDATE()
)


IF OBJECT_ID('silver.crm_prod_info','U') IS NOT NULL
	DROP  TABLE silver.crm_prod_info;
CREATE TABLE silver.crm_prod_info(
prd_id INT,cat_id NVARCHAR(50)
,prd_key NVARCHAR(50),prd_nm NVARCHAR(50)
,prd_cost FLOAT,prd_line NVARCHAR(20),
prd_start_dt DATE,prd_end_dt DATE,
dwh_create_date DATETIME2 DEFAULT GETDATE())



IF OBJECT_ID('silver.crm_Sales_info','U') IS NOT NULL
	DROP  TABLE silver.crm_Sales_info
CREATE TABLE silver.crm_Sales_info(
sls_ord_num NVARCHAR(50),sls_prd_key NVARCHAR(50),sls_cust_id INT
,sls_order_dt DATE,sls_ship_dt DATE,
sls_due_dt DATE,sls_sales INT,sls_quantity INT,sls_price INT,
dwh_create_date DATETIME2 DEFAULT GETDATE())



IF OBJECT_ID('silver.erp_CUST_Personal_info','U') IS NOT NULL
	DROP  TABLE silver.erp_CUST_Personal_info
CREATE TABLE silver.erp_CUST_Personal_info(
CID NVARCHAR(50),BDATE DATE,GEN NVARCHAR(20),
dwh_create_date DATETIME2 DEFAULT GETDATE())



IF OBJECT_ID('silver.erp_CUST_Country','U') IS NOT NULL
	DROP  TABLE silver.erp_CUST_Country
CREATE TABLE silver.erp_CUST_Country (
CID NVARCHAR(50),CNTRY NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE())


IF OBJECT_ID('silver.erp_PX_CAT','U') IS NOT NULL
	DROP  TABLE silver.erp_PX_CAT
CREATE TABLE silver.erp_PX_CAT (
ID NVARCHAR(50),CAT NVARCHAR(50),SUBCAT NVARCHAR(50),MAINTENANCE NVARCHAR(20) ,
dwh_create_date DATETIME2 DEFAULT GETDATE())
