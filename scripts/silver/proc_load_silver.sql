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

select * from silver.crm_cust_info

/*
select prd_id ,
count(*)
from bronze.crm_prd_info
group by prd_id
having count(*)>1 or count(*) is null
*/

select * from bronze.crm_prd_info


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

select distinct prd_line
from bronze.crm_prd_info


select * from 
bronze.crm_prd_info
where prd_end_dt < prd_start_dt or prd_end_dt is null or prd_start_dt is null

