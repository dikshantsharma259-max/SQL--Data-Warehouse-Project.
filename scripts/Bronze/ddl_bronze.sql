/*======================================================================
  DDL SCRIPTS :CREATE BRONZE LAYER
  =============================================================
  PURPOSE: this scripts create a schemas for each data in bronze layer
  Can easily be altered and changed based over the task .
================================================*/

IF OBJECT_ID('Bronze.crm_Cust_info','U') IS NOT NULL
	DROP  TABLE Bronze.crm_Cust_info;
CREATE TABLE Bronze.crm_Cust_info (
cst_id INT,cst_key NVARCHAR(50),
cst_firstname NVARCHAR(20),cst_lastname NVARCHAR(20),
cst_marital_status NVARCHAR(5),cst_gndr NVARCHAR(5)
,cst_create_date DATE
)


IF OBJECT_ID('Bronze.crm_prod_info','U') IS NOT NULL
	DROP  TABLE Bronze.crm_prod_info;
CREATE TABLE Bronze.crm_prod_info(
prd_id INT
,prd_key NVARCHAR(50),prd_nm NVARCHAR(50)
,prd_cost FLOAT,prd_line NVARCHAR(20),
prd_start_dt DATETIME,prd_end_dt DATETIME)



IF OBJECT_ID('Bronze.crm_Sales_info','U') IS NOT NULL
	DROP  TABLE Bronze.crm_Sales_info
CREATE TABLE Bronze.crm_Sales_info(
sls_ord_num NVARCHAR(50),sls_prd_key NVARCHAR(50),sls_cust_id INT
,sls_order_dt NVARCHAR(50),sls_ship_dt NVARCHAR(50),
sls_due_dt NVARCHAR(50),sls_sales INT,sls_quantity INT,sls_price INT)



IF OBJECT_ID('Bronze.erp_CUST_Personal_info','U') IS NOT NULL
	DROP  TABLE Bronze.erp_CUST_Personal_info
CREATE TABLE Bronze.erp_CUST_Personal_info(
CID NVARCHAR(50),BDATE DATE,GEN NVARCHAR(20) )



IF OBJECT_ID('Bronze.erp_CUST_Country','U') IS NOT NULL
	DROP  TABLE Bronze.erp_CUST_Country
CREATE TABLE Bronze.erp_CUST_Country (
CID NVARCHAR(50),CNTRY NVARCHAR(50) )


IF OBJECT_ID('Bronze.erp_PX_CAT','U') IS NOT NULL
	DROP  TABLE Bronze.erp_PX_CAT
CREATE TABLE Bronze.erp_PX_CAT (
ID NVARCHAR(50),CAT NVARCHAR(50),SUBCAT NVARCHAR(50),MAINTENANCE NVARCHAR(20) )
