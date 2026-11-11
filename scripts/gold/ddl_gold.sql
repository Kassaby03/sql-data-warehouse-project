Use DataWarehouse

create view gold.dim_customers as 

SELECT 
ROW_NUMBER() over(order by cst_id) as Customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
la.cntry as country, 
ci.cst_martial_status as marital_status,
case
  when ci.cst_gndr !='n/a' then cst_gndr 
  else coalesce(ca.gen,'n/a')
END customer_gender,
ca.bdate as birthdate,
ci.cst_create_date as create_date
FROM silver.crm_cust_info ci left join silver.erp_cust_az12 ca on ci.cst_key =ca.cid 
left join silver.erp_loc_a101  la on ca.cid = la.cid

create view gold.dim_products as
select 
    ROW_NUMBER() over(order by pr.prd_start_dt, pr.prd_key) product_key,
	pr.prd_id as product_id,
	pr.prd_key as product_number,
	pr.prd_nm as product_name,
	pr.cat_id as category_id,
	cat.cat as category,
	cat.subcat as subcategory,
	cat.maintenance as maintenance,
	pr.prd_cost as product_cost,
	pr.prd_line as product_line,
	pr.prd_start_dt as start_date
from silver.crm_prd_info pr left join silver.erp_px_cat_g1v2 cat on pr.cat_id= cat.id
where pr.prd_end_dt is null

create view gold.fact_sales as

select 
sd.sls_ord_num as order_number,
pr.product_key,
cu.Customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales_amount,
sd.sls_quantity as quantity,
sd.sls_price as price

from silver.crm_sales_details sd left join gold.dim_products pr on sd.sls_prd_key = pr.product_number 
left join gold.dim_customers cu on sd.sls_cust_id = cu.customer_id


