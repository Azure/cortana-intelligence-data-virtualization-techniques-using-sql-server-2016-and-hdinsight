## Appendix  

### Some TSQL HiveQL and ANSI SQL syntax intersections

##### Renaming a table
Supported on both T-SQL and HIVE with slight differences.
- [T-SQL](https://msdn.microsoft.com/en-us/library/mt631611.aspx)
	- SQL DW/PDW

    ```  
	RENAME OBJECT [ :: ]  [ [ database_name .  [schema_name ] ] . ] | [schema_name . ] ] table_name TO new_table_name [;]  

    ```

    - SQL Server and DB : Use Stored Procedure [sp_renamedb](https://msdn.microsoft.com/en-us/library/ms186217.aspx)

    ```
    sp_renamedb [ @dbname = ] 'old_name' , [ @newname = ] 'new_name'  

    ```

- [HIVE](http://www.tutorialspoint.com/hive/hive_alter_table.htm)

```
ALTER TABLE name RENAME TO new_name
```

##### Cloning Table schema without copying data (Create Table Like - CTL)
Supported directly on [HIVE](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-CreateTableLike) alone.

```
CREATE TABLE newEmptyTableWithSchema LIKE realTableWeNeedSchemaFrom;
```

However, you can achieve a similar result in T-SQL using a `SELECT INTO` statement

```
 SELECT TOP 0 * INTO newEmptyTableWithSchema FROM realTableWeNeedSchemaFrom;
```


##### Creating External Tables
Supported on [HIVE](http://www.tutorialspoint.com/hive/hive_create_table.htm) and [T-SQL with PolyBase alone](https://msdn.microsoft.com/en-us/library/mt163689.aspx) on SQL Server 16 and Data Warehouse (SQL and Parallel).  


##### Creating Table As Select (CTAS)
Supported on [HIVE](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-CreateTableAsSelect(CTAS)) and T-SQL for [Azure SQL DW and Parallel DW](https://msdn.microsoft.com/en-us/library/mt204041.aspx)

##### Creating External Table As Select (CETAS)
Supported in T-SQL (with PolyBase) on [Azure SQL DW and Parallel DW](https://msdn.microsoft.com/en-us/library/mt631610.aspx) but **NOT** supported in HIVE.    

Hive supports only **CTAS** with the following ceveats **FULLY** documented on [Apache Hive Confluence Page](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL)  

> CTAS has these restrictions:  
The target table cannot be a partitioned table.  
_**The target table cannot be an external table.**_   
The target table cannot be a list bucketing table.


##### Update
Supported on [T-SQL](https://msdn.microsoft.com/en-us/library/ms177523.aspx) for internal tables.

> NOTE  
`UPDATE` is not supported on external tables. Only the following are allowed on external tables.  
- CREATE and DROP TABLE  
- CREATE AND DROP STATISTICS  
- CREATE AND DROP VIEW  

>For further information check [Limitations and Restrictions of T-SQL Create External Table](https://msdn.microsoft.com/en-us/library/dn935021.aspx)

Support for [HIVE] is available from [version 0.14](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DML#LanguageManualDML-Update) on tables that support ACID properties.


##### Delete
Supported on [T-SQL](https://msdn.microsoft.com/en-us/library/ms189835.aspx) for internal tables.
> NOTE  
No `DML` is allowed on external tables.  
Find more information [here.](https://msdn.microsoft.com/en-us/library/mt631610.aspx)

Support for HIVE is available from [version 0.14](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DML#LanguageManualDML-Update) on tables that support ACID properties.


##### Insert Into Select

Supported in [HIVE](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DML#LanguageManualDML-InsertingdataintoHiveTablesfromqueries) and [T-SQL](https://msdn.microsoft.com/en-us/library/ms174335.aspx)  


##### Rollup, Cube, Grouping Sets
Supported in [T-SQL](https://technet.microsoft.com/en-us/library/bb522495(v=sql.105).aspx) and [HIVE](https://cwiki.apache.org/confluence/display/Hive/Enhanced+Aggregation,+Cube,+Grouping+and+Rollup)

##### Common Table Expressions (Queries specified in a WITH clause)
Supported in [T-SQL](https://technet.microsoft.com/en-us/library/ms190766(v=sql.105).aspx) and [HIVE](https://cwiki.apache.org/confluence/display/Hive/Common+Table+Expression)


##### User Defined Functions (UDF)  
Supported in [HIVE](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+UDF) and [T-SQL](https://msdn.microsoft.com/en-us/library/ms191320.aspx) with certain ceveats.  


**NOTE**
> ##### Hive For SQL Users  
> For customers that are already know SQL, [Horton Works](http://hortonworks.com/) has created a handy Hive
["Cheat Sheet"](http://hortonworks.com/blog/hive-cheat-sheet-for-sql-users/) for SQL users.
It'll be a very useful tool to assist your translation of SQL logic to Hive on HDInsight.  


> For further readings, these external links could be interesting.

> 1. [Subtle differences between HiveQL and SQL](http://www.wmanalytics.io/blog/list-subtle-differences-between-hiveql-and-sql) by WebMasson Analytics.

> 2. [Difference Between SQL and T-SQL](http://www.differencebetween.net/technology/software-technology/difference-between-sql-and-t-sql/) by www.diferencebetween.net

###### Start PolyBase service in deployed SQL Server 2016  
The pre-packaged image of the SQL Server 2016 has PolyBase already installed. However, the PolyBase services (Data Movement and Engine Services) are tied to the network identification of the original installation, causing both services not to start automatically. Trying to start the service manually gives an error.


![PolyBase Service fails to start on deploy](./assets/media/POLYBASE-RESTART11.PNG "PolyBase Service fails to start on deploy")

Let's walk through restarting PolyBase service.

![PolyBase Service fails to start on deploy](./assets/media/POLYBASE-DEADSERVICE1.PNG "PolyBase Service fails to start on deploy")



![PolyBase Service fails to start on deploy](./assets/media/POLYBASE-DEADSERVICE2.PNG "PolyBase Service fails to start on deploy")
You would need to reinstall PolyBase as a feature on the SQL Server instance tied to your authentication.  

The following will walk you through the reinstallation process using the SQL Server ISO that is pre-loaded on the VM.  

1.  Remove PolyBase as a feature:
	- Go to **Program and Features**  on the SQL Server VM _**(Control Panel\Programs\Programs and Features)**_  

	- Select the version of Microsoft SQL Server 2016 installed (64bit in this case) and click on **Uninstall/Change**
	![Uninstall/Change PolyBase](./assets/media/POLYBASE-RESTART1.PNG "Change the MSSQL installation to remove PolyBase")  

	- Click on **Remove**
	![Click on Remove on MSSQLSERVER Instance](./assets/media/POLYBASE-RESTART2.PNG "Click on Remove on MSSQLSERVER Instance")  

	- Select **MSSQLSERVER** Instance and click on **Next** to proceed
	![Select MSSQLSERVER Instance](./assets/media/POLYBASE-RESTART3.PNG "Select MSSQLSERVER Instance")

	- Select **PolyBase Query Service for External Data** and keep clicking on **Next** to remove PolyBase.
	![Remove PolyBase from MSSQLSERVER Instance](./assets/media/POLYBASE-RESTART4.PNG "Remove PolyBase from MSSQLSERVER Instance")

	- Remove
	![Final PolyBase removal](./assets/media/POLYBASE-RESTART5.PNG "Final PolyBase removal")

At this point PolyBase is completely uninstalled from the SQL Server 2016. Now we will reinstall and start services.

2. Reinstall PolyBase:
A SQL Server ISO is saved on the VM **"C"** drive for easy reinstall.   
	- Navigate to **C:\TUTORIAL_EXTRAS_OPEN_ME\SQLServer_13.0_Full** on the VM and click on **setup** icon.
	![Start PolyBase Setup](./assets/media/POLYBASE-RESTART6.PNG "Starting PolyBase Setup")  

	- Go to **Installation** on the left tab and then click on **New SQL Server stand-alone installation or add features to an existing installation**
		![Add PolyBase as a feature](./assets/media/POLYBASE-RESTART7.PNG "Add PolyBase as a feature")

	- Click through to **Installation Type** on the left column and then select **MSSQLSERVER** as the instance you would love to add PolyBase on to.
	![Select MSSQLSERVER as Instance for PolyBase](./assets/media/POLYBASE-RESTART8.PNG "Select MSSQLSERVER as Instance for PolyBase")

	- Check the **PolyBase Query Service for External Data** box and click **Next**
	![Select PolyBase as a feature](./assets/media/POLYBASE-RESTART9.PNG "Select PolyBase as a feature")  

	- Select SQL Server as a standalone instance
		![Single PolyBase Instance](./assets/media/POLYBASE-RESTART12.PNG "Single PolyBase Instance.")  

	- Continue to Install
		![Single PolyBase Instance](./assets/media/POLYBASE-RESTART13.PNG "Single PolyBase Instance.")  

	- Final confirmation
		![Single PolyBase Instance](./assets/media/POLYBASE-RESTART14.PNG "Single PolyBase Instance.")  

	- Make sure that PolyBase services start automatically and are running normally; without affecting any SQL Service.
		![Confirm PolyBase and MSSQLSERVER Services are running](./assets/media/POLYBASE-RESTART10.PNG "Confirm PolyBase and MSSQLSERVER Services are running.")  
