use DataWarehouse

INSERT INTO silver.crm_cust_info(
			cst_id, 
			cst_key, 
			cst_firstname, 
			cst_lastname, 
			cst_martial_status, 
			cst_gndr,
			cst_create_date
		)
SELECT
cst_id,
cst_key,
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname,
CASE
	WHEN upper(cst_martial_status)='M' THEN 'Married'
	WHEN upper(cst_martial_status)='S' THEN 'Single'
	ELSE 'n/a'
END AS cst_martial_status,
CASE
	WHEN upper(cst_gndr)='M' THEN 'Male'
	WHEN upper(cst_gndr)='F' THEN 'Female'
	ELSE 'n/a'
END AS cst_gndr,
create_date
FROM
(
    SELECT *,ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY create_date DESC) AS flag_last
	FROM bronze.crm_cust_info
	WHERE cst_id is not null

) t
where flag_last=1




insert into silver.crm_prd_info
(
prd_id ,
cat_id ,
prd_key ,
prd_nm ,
prd_cost ,
prd_line ,
prd_start_dt ,
prd_end_dt 
)
Select 
prd_id,
REPLACE(SUBSTRING(prd_key,1,5),'-','_') As cat_id,
SUBSTRING(prd_key,7,len(prd_key)),
prd_nm,
isnull(prd_cost,0) AS prd_cost,
case 
    when upper(trim(prd_line))='M' THEN 'Mountain'
	when upper(trim(prd_line))='R' THEN 'Road'
	when upper(trim(prd_line))='S' THEN 'Other sales'
	when upper(trim(prd_line))='T' THEN 'Touring'
	ELSE 'N/A'
END AS prd_line,
cast(prd_start_dt AS DATE),
cast(LEAD(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 AS DATE) prd_end_dt
from bronze.crm_prd_info


INSERT INTO silver.crm_sales_details
(
sls_ord_num,
sls_prd_key ,
sls_cust_id ,
sls_order_dt,
sls_ship_dt ,
sls_due_dt ,
sls_sales ,
sls_quantity ,
sls_price 

)

select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case 
  when sls_order_dt=0 or LEN(sls_order_dt)!=8 THEN NULL
  ELSE CAST(CAST(sls_order_dt as varchar) AS DATE)
END as sls_order_dt,
case 
    when sls_ship_dt=0 or LEN(sls_ship_dt)!=8 THEN NULL
    ELSE CAST(CAST(sls_ship_dt as varchar) AS DATE)
END as sls_ship_dt,
CASE
    when sls_due_dt=0 or LEN(sls_due_dt)!=8 THEN NULL
    ELSE CAST(CAST(sls_due_dt as varchar) AS DATE)
END as sls_due_dt,
case 
	when sls_sales<0 or sls_sales is null or sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	else sls_sales
End as sls_sales,

sls_quantity,

CASE 
	WHEN sls_price<0 or sls_price is null 
	THEN sls_sales/nullif(sls_quantity,0)
	ELSE sls_price
END as sls_price
from bronze.crm_sales_details



select * from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt or sls_sales<0 or sls_sales is null or sls_price<0 or sls_price is null 
or sls_sales != sls_price * sls_quantity