/* 
=================================================
Stored procedure: Load Bronze layer (source -> bronze)
==================================================
Script purpose:
The stored procedure loads data in the bronze schema from the external csv file
it truncates the bronze tables before loading the data, uses the 'BULK INSERT' to load data
The stored procedure does not accept any parameters or return any value
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME, 
            @end_time DATETIME;

    BEGIN TRY
        PRINT '=============================';
        PRINT 'Loading Bronze Layer';
        PRINT '=============================';

        -----------------------------
        -- CRM TABLES
        -----------------------------
        PRINT 'Loading CRM Tables';

        -- 1. crm_cust_info
        SET @start_time = GETDATE();

        PRINT '>> Truncating: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\User\Desktop\DWH Material\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Time (crm_cust_info): ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -- 2. crm_prd_info
        SET @start_time = GETDATE();

        PRINT '>> Truncating: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\User\Desktop\DWH Material\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Time (crm_prd_info): ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -- 3. crm_sales_details
        SET @start_time = GETDATE();

        PRINT '>> Truncating: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\User\Desktop\DWH Material\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Time (crm_sales_details): ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -----------------------------
        -- ERP TABLES
        -----------------------------
        PRINT 'Loading ERP Tables';

        -- 4. erp_cust_az12
        SET @start_time = GETDATE();

        PRINT '>> Truncating: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\User\Desktop\DWH Material\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Time (erp_cust_az12): ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -- 5. erp_loc_a101
        SET @start_time = GETDATE();

        PRINT '>> Truncating: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\User\Desktop\DWH Material\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Time (erp_loc_a101): ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        -- 6. erp_px_cat_g1v2
        SET @start_time = GETDATE();

        PRINT '>> Truncating: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\User\Desktop\DWH Material\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Time (erp_px_cat_g1v2): ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';


        PRINT '=============================';
        PRINT 'Bronze Layer Load Completed';
        PRINT '=============================';

    END TRY
    BEGIN CATCH
        PRINT '======================================';
        PRINT 'Error occurred when loading bronze layer';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT '======================================';
    END CATCH
END;
