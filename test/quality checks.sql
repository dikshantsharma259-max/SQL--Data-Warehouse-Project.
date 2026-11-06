
/* ======================================================
this are the quality checks for the confirmation of gender 
considering crm customer info as the master and correct data
===========================================================*/
SELECT DISTINCT
	CI.cst_gndr,
	PCI.GEN,
	CASE 
	WHEN cst_gndr != 'N/A' THEN cst_gndr
	ELSE COALESCE(PCI.GEN,'N/A')
	END AS NEW_GEN
	FROM silver.crm_Cust_info CI
	LEFT JOIN silver.erp_CUST_Country CNT
	ON CI.cst_key = CNT.CID
	LEFT JOIN silver.erp_CUST_Personal_info PCI
	ON CI.cst_key = PCI.CID
	ORDER BY 1,2

