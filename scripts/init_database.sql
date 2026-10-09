/*
========================================================================
                          CREATE DATABASE AND SCHEMA
========================================================================

WARNING: 
       Running This Script Will drop Entire Database DataWarehouse

*/

use master;
GO


IF EXISTS (SELECT 1 FROM sys.databases where name='DataWarehouse')
BEGIN 

ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP  DATABASE DataWarehouse;

END;

CREATE DATABASE DataWarehouse;
GO

use DataWarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
Go

CREATE SCHEMA gold;
GO
