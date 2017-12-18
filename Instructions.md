## Resource provisioning (manual)

Okay, almost done! You need to do these two steps before you can test the solution:

1. Log in to your VM with IP address **{Outputs.virtualMachineIP}**, username: \\&lt;username&gt; and password:&lt;password&gt; (&lt;username&gt; and &lt;password&gt; are the values you chose at the beginning of this deployment).

  You can connect to your VM using the built-in Windows Remote Desktop Connection client, or for your convenience, you can download the .RDP connection file from the [VM Status Page]({Outputs.virtualMachinePortalUri}) by clicking the `Connect` button there.

1. From the VM, double click the shortcut **Setup - Data Virtualization** on the desktop and wait for the script to finish. It typically takes about 10-12 minutes to run.

> **At this point you will need to wait until the setup on your VM finishes before you proceed to the next section. Also, keep your session to your VM open, as you will use it in the next section.**

## Take it for a spin

Congratulations! You have successfully deployed the data virtualization tutorial.

Now that everything is deployed, you're ready to explore two data virtualization techniques:
1. Query Scale-out
2. Hybrid Execution

## Query Scale-out

Query Scale-out shows how to scale a query from a hardware constrained SQL Server 2016 to an HDInsight (HDI) cluster using PolyBase. First, let's test a query running entirely in the SQL Server.

### Run on local resources only

First we are going to look at the case where everything runs in your SQL Server. To do this, follow the steps below:

Using your existing client session to your virtual machine, do the following steps:

1. Double click **SQL - Data Virtualization** on your desktop.
1. It will bring up sample SQL folder in Explorer.
1. Double click **select-without-pushdown.sql**
1. Double click **SQL Server Management Studio** (SSMS). It takes a few minutes for SSMS to come up the first time.
1. Click **Connect** using all default values.

You will be running a query that joins table data entirely on the SQL Server running on your virtual machine. Note that for the purposes of this tutorial we allow the sample query to run on the SQL Server without adding any extra load nor execute any other query in parallel.

Click anywhere on the SQL statement to get focus then click **Execute**. You can also use the F5 function key to start execution.

Note the execution time. This will vary, but typically will exceed one minute. ***As of this writing, it took 1 minute and 16 seconds.***

However, in production environments usually multiple queries run in parallel competing for memory, CPU, I/O. This further deteriorates query performance. In a big data context, it is also very likely that the sheer amount of data would not fit in your SQL Server.

### Run by scaling out to Hadoop (distributed environment)

Now let's look at how you can speed things up by offloading some of the work to an HDI cluster. We're going to run the same query, but this time the ‘where’ clause will be executed on HDI.

Again, using your client session to your virtual machine, do the following steps:
1.	Double click **SQL - Data Virtualization** on your desktop to open the sample SQL folder.
2.	Double click **select-with-pushdown.sql**
3.	Click anywhere on the SQL statement to get focus then click **Execute**. You can also use Function F5 to kick start execution.

Note the execution time. This will vary, but typically will be less that one minute. ***As of this writing, it took 55 seconds.***

The ‘where’ clause of the query you just ran was executed on the HDI cluster, where map reduce jobs were executed under the hood to crunch the data and return only the results. The results were then incorporated back into the local query execution.

Most production Analytics systems already have data archived in big data stores that can come in handy when implementing this technique for scaling out SQL query execution without the need to move data. This approach can be used to significantly speed up your query execution times when working with long running queries on a shared SQL Server instance.

The query optimizer (part of PolyBase) can dynamically decide whether to execute the query on SQL Server or to scale out the execution.

## Hybrid Execution
Hybrid Execution shows a technique to read and join the table data stored in an Azure blob with data in SQL Data Warehouse.

Many production systems need reference data stored in SQL databases and data warehouses (such as sales or location data) to transform (ETL) the data residing in big data stores like Azure storage, Azure Data Lake, etc. used by HDI.

You can imagine a scenario where you have lots of processed data residing in HDI, written out to Azure storage or Azure Data Lake, that needs to be joined with reference data stored in a SQL environment. We are demonstrating this technique using Jupyter Notebook running on your HDI cluster. The following steps will execute one query in HDI and another in SQL Data Warehouse and merge the results in HDI.

Using a browser of your choice, do the following steps:
1.	Browse to the Jupyter Notebook installed on your HDI cluster by clicking [here]({Outputs.jupyterNotebookUri}).
1.	Login using the same user name and password you used during the deployment.
1.	Select and run each of the cells from top to bottom, waiting for each cell to finish before moving on to the next one. You can tell when a cell has finished executing because the * will no longer be there.

After running all these steps, you should see the top 20 matching rows.

The key here is to notice the combined result set produced by joining sales data, stored in a SQL Data Warehouse, with product data, stored in the primary backing blob store for the HDInsight cluster.


## Cleaning Up

> **When you are all done, you should delete this solution or you will continue to be charged for hosting these resources.**
