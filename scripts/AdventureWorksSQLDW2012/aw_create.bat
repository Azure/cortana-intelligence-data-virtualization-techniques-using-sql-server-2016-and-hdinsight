REM AdventureWorksSQLDW2012 sample database version 3.0 for DW Service

@echo off

REM !!!!!!!!!!!!!!!!!!!!!!!!!!!!
REM Start User Defined Variables
REM !!!!!!!!!!!!!!!!!!!!!!!!!!!!

set server=%1
set user=%2
set password=%3
set database=%4
set p1=%5
set schema=dbo

REM echo server=%server%
REM echo user=%user%
REM echo password=%password%
REM echo database=%database%

REM !!!!!!!!!!!!!!!!!!!!!!!!!!!!
REM End User Defined Variables
REM !!!!!!!!!!!!!!!!!!!!!!!!!!!!

set tables=AdventureWorksDWBuildVersion, DatabaseLog, DimAccount, DimCurrency, DimCustomer, DimDate, DimDepartmentGroup, DimEmployee, DimGeography, DimOrganization, DimProduct, DimProductCategory, DimProductSubcategory, DimPromotion, DimReseller, DimSalesReason, DimSalesTerritory, DimScenario, FactCallCenter, FactCurrencyRate, FactFinance, FactInternetSales, FactInternetSalesReason, FactResellerSales, FactSalesQuota, FactSurveyResponse, ProspectiveBuyer
set views=AggregateSales
set ddl=aw_ddl.sql
set validation=aw_check.sql
set statistics=aw_create_statistics.sql
REM set p1=.
set logs=%p1%\logs
REM set load="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\bcp.exe"
REM set mode=reload
REM set login_timeout=120
set login_timeout=5

mkdir %logs% 2> nul
del %logs%\*.log 2> nul

if "%server%"=="" (
    echo %date% %time% Server needs to be specified.
    goto eof
)

if "%user%"=="" (
    echo %date% %time% User needs to be specified.
    goto eof
)

if "%password%"=="" (
    echo %date% %time% Password needs to be specified.
    goto eof
)

if "%database%"=="" (
    echo %date% %time% Database needs to be specified.
    goto eof
)

REM if not exist %load% (
REM     echo %date% %time% Bcp must be installed.
REM     goto eof
REM )

echo %date% %time% Creating Schema %schema% if it does not exist
sqlcmd -S "%server%" -U %user% -P %password% -d %database% -I -l %login_timeout% -e -Q "CREATE SCHEMA %schema%" >> %logs%\create_schema.log

echo %date% %time% Dropping Existing Adventure Works Tables and Views

for %%t in (%tables%) do (
    sqlcmd -S "%server%" -U %user% -P %password% -d %database% -I -l %login_timeout% -e -Q "IF EXISTS (SELECT NULL FROM sys.tables WHERE name = '%%t' AND schema_id IN (SELECT schema_id FROM sys.schemas where name = '%schema%')) DROP TABLE %schema%.%%t" >> %logs%\drop_tables.log
)

for %%v in (%views%) do (
    sqlcmd -S "%server%" -U %user% -P %password% -d %database% -I -l %login_timeout% -e -Q "IF EXISTS (SELECT NULL FROM sys.views WHERE name = '%%v' AND schema_id IN (SELECT schema_id FROM sys.schemas where name = '%schema%')) DROP VIEW %schema%.%%v" >> %logs%\drop_views.log
)

echo %date% %time% Existing Adventure Works Tables and Views Dropped

echo %date% %time% Creating Adventure Works Tables and Views

sqlcmd -S "%server%" -U %user% -P %password% -d %database% -I -i %p1%\%ddl% -l %login_timeout% -b -e -v schema="%schema%" >> %logs%\ddl.log

if %ERRORLEVEL% NEQ 0 (
   echo %date% %time% Create DDL statement failed. Please look at the file %output_file% for errors.
   goto eof
)

echo %date% %time% Adventure Works Tables and Views Created

echo %date% %time% Loading Adventure Works Tables

for %%x in (%tables%) do (

    @echo on
    echo. >> %logs%\loads.log
    echo %date% %time% Loading %schema%.%%x >> %logs%\loads.log
    REM %load% %schema%.%%x in "%p1%\%%x.txt" -S%server%  -U%user% -P%password% -t"|" -d%database% -w -q >> %logs%\loads.log
    bcp %schema%.%%x in "%p1%\%%x.txt" -S%server%  -U%user% -P%password% -t"|" -d%database% -w -q >> %logs%\loads.log
    @echo off

    if %ERRORLEVEL% NEQ 0 (
         echo %date% %time% Load for table %schema%.%%x failed. Please look at the file %logs%\load_%%x.log for errors.
    ) ELSE (
          echo %date% %time% Table %schema%.%%x loaded
    )

)

echo %date% %time% Adventure Works Tables Loaded

echo %date% %time% Validating Row Counts
sqlcmd -S "%server%" -U %user% -P %password% -d %database% -I -i %p1%\%validation% -l %login_timeout% -v schema="%schema%"

REM echo %date% %time% Collecting Statistics on all Columns (Approximate Run Time is 15 Minutes)
REM sqlcmd -S "%server%" -U %user% -P %password% -d %database% -I -i %p1%\%statistics% -l %login_timeout% -e -p -v schema="%schema%" >> %logs%\statistics.log
REM echo %date% %time% Statistics Collected on all Columns

:eof