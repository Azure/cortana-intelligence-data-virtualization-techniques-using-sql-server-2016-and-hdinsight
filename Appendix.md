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
