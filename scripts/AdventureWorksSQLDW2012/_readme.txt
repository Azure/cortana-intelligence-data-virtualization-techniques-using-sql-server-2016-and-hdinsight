This zip file contains the scripts and table data to install the AdventureWorksSQLDW2012 sample database onto Microsoft® SQL DW Service.

Before you install AdventureWorksSQLDW2012:
-------------------------------------------

1. Create a Logical Server and/or Database on the desired cluster using the Azure Portal.
   See https://azure.microsoft.com/documentation/articles/sql-data-warehouse-get-started-provision/

2. Install sqlcmd.exe.  Version 11.0.2100.60 or later required for SQL Azure.
   See https://azure.microsoft.com/documentation/articles/sql-data-warehouse-get-started-connect-query-sqlcmd/

3. Install bcp.exe.  Version 11.0.2100.60 or later required for SQL Azure.
   See https://azure.microsoft.com/documentation/articles/sql-data-warehouse-load-with-bcp/

To install AdventureWorksSQLDW2012:
-----------------------------------

4. Extract files from AdventureWorksSQLDW2012.zip file into a directory.

5. Edit aw_create.bat setting the following variables:
   a. server=<servername> from step 1.  e.g. mylogicalserver.database.windows.net 
   b. user=<username> from step 1 or another user with proper permissions
   c. password=<passwordname> for user in step 5b
   d. database=<database> created in step 1
   e. schema=<schema> this schema will be created if it does not yet exist

6. Run aw_create.bat from a cmd prompt, running from the directory where the files were unzipped to.
   This script will...
   a. Drop any Adventure Works tables or views that already exist in the schema
   b. Create the Adventure Works tables and views in the schema specified
   c. Load each table using bcp
   d. Validate the row counts for each table
   e. Collect statistics on every column for each table
