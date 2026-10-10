CREATE OR ALTER  PROCEDURE bronze.load_bronze AS

BEGIN
    BEGIN TRY
        DECLARE @start_time DATETIME, @end_time DATETIME, @start_batch_time DATETIME, @end_batch_time DATETIME
        set @start_batch_time= GETDATE();
        PRINT'==============================================';
        PRINT'Loading Bronze Layer';
        PRINT'==============================================';

        PRINT'-----------------------------------------------';
        PRINT'LOADIND CRM TABLES';
        PRINT'-----------------------------------------------';

        SET @start_time= GETDATE();
        PRINT'>>TRUNCATING TABLE: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT'>>INSERT DATA INTO: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\Data with baraa\My Work\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH(
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        TABLOCK

        );
        SET @end_time=GETDATE();
        PRINT'LOAD DURATION: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT'>>----------'
   

        --------------------------------------------------------------------------------------------
        SET @start_time=GETDATE();
        PRINT'>>TRUNCATING TABLE: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT'>>INSERT DATA INTO: bronze.crm_prd_info';

        BULK INSERT bronze.crm_prd_info
        FROM 'D:\Data with baraa\My Work\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH(
             FIRSTROW=2,
             FIELDTERMINATOR=',',
             TABLOCK
        );

        SET @end_time=GETDATE();
        PRINT'LOAD DURATION: '+ CAST (DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT'>>----------'
        --------------------------------------------------------------------------------------------
        SET @start_time=GETDATE();
        PRINT'>>TRUNCATING TABLE: bronze.crm_sales_details';


        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT'>>INSERT DATA INTO: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM 'D:\Data with baraa\My Work\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH
        (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        TABLOCK
        );
        SET @end_time=GETDATE();
        PRINT'LOAD DURATION: '+ CAST (DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT'>>----------'
        --------------------------------------------------------------------------------------------
        SET @start_time=GETDATE();

        PRINT'-----------------------------------------------';
        PRINT'LOADIND ERP TABLES';
        PRINT'-----------------------------------------------';

       
        PRINT'>>TRUNCATING TABLE: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT'>>INSERT DATA INTO: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\Data with baraa\My Work\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        with
        (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        TABLOCK
        );
        SET @end_time=GETDATE();
        PRINT'LOAD DURATION: '+ CAST (DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT'>>----------'
        --------------------------------------------------------------------------------------------
        SET @start_time=GETDATE();

        PRINT'>>TRUNCATING TABLE: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT'>>INSERT DATA INTO: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\Data with baraa\My Work\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH
        (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        TABLOCK
        );
        SET @end_time=GETDATE();
        PRINT'LOAD DURATION: '+ CAST (DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT'>>----------'
        --------------------------------------------------------------------------------------------
        SET @start_time=GETDATE();
        PRINT'>>TRUNCATING TABLE: bronze.erp_px_cat_g1v22';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT'>>INSERT DATA INTO: bronze.erp_px_cat_g1v22';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\Data with baraa\My Work\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        TABLOCK

        );

        SET @end_time=GETDATE();
        PRINT'LOAD DURATION: '+ CAST (DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT'>>----------'
        --------------------------------------------------------------------------------------------

        SET @end_batch_time=GETDATE();
        PRINT'===================================================================='
        PRINT'Bronzze Layer Duration: ' + CAST(DATEDIFF(second,@start_batch_time,@end_batch_time) AS NVARCHAR) +' Seconds'
        PRINT'===================================================================='

    END TRY
    BEGIN CATCH
        PRINT'--------------------------------------------------------'
        PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT'ERROR MESSAGE' + ERROR_MESSAGE();
        PRINT'ERROR MESSAGE' + CAST (ERROR_NUMBER()  AS NVARCHAR);
        PRINT'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT'--------------------------------------------------------'
    END CATCH
END

