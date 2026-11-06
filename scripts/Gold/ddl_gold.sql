/* ===================================================================
THIS IS DDL SCRIPT OF GOLD LAYER OF VIEW OF THE CUMILATIVE TABLES OF ALL THE DATA 
THIS HELP THE USERS TO EASILY ACCESS THE ORGANISED DATA OF ALL THE LAYERS
============================================================================*/


CREATE VIEW Gold.dim_customers AS
SELECT 
ROW_NUMBER()OVER(ORDER BY cst_id) Customer_key,
	CI.cst_id Customer_id,
	CI.cst_key Customer_number,
	CI.cst_firstname Firstname,
	CI.cst_lastname Lastname,
	CASE 
	WHEN cst_gndr != 'N/A' THEN cst_gndr
	ELSE COALESCE(PCI.GEN,'N/A')
	END AS Gender,
	CNT.CNTRY Country,
	CI.cst_marital_status  Marital_status ,
	PCI.BDATE  Birthdate,
	CI.cst_create_date  Customer_creation_date	
	FROM silver.crm_Cust_info CI
	LEFT JOIN silver.erp_CUST_Country CNT
	ON CI.cst_key = CNT.CID
	LEFT JOIN silver.erp_CUST_Personal_info PCI
	ON CI.cst_key = PCI.CID

CREATE VIEW Gold.dim_Product AS
SELECT 
ROW_NUMBER()OVER(ORDER BY prd_start_dt,prd_key) Product_key,
prod.prd_id Product_id,
prod.prd_key Product_number,
prd_nm Product_name,
prod.cat_id Category_id,
pcat.CAT Category,
pcat.SUBCAT Sub_Category,
pcat.MAINTENANCE,
prd_cost Product_cost,
prd_line Product_line,
prd_start_dt Starting_Date
FROM silver.crm_prod_info prod
LEFT JOIN silver.erp_PX_CAT pcat
ON prod.cat_id = pcat.ID
WHERE prd_end_dt IS NULL

CREATE VIEW Gold.dim_Sales AS
SELECT 
sls_ord_num Order_number,
Pr.Product_key ,
Cu.Customer_key,
sls_order_dt Order_Date,
sls_due_dt Order_Due_Date,
sls_quantity Quantity,
sls_price Price,
sls_sales Sales
FROM silver.crm_Sales_info Sls
LEFT JOIN Gold.dim_product Pr
ON Sls.sls_prd_key = Pr.Product_number
LEFT JOIN Gold.dim_customers Cu
on Sls.sls_cust_id = Cu.Customer_id

