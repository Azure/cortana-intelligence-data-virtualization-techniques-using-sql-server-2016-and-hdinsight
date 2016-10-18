## Troubleshooting  

#### Some issues and recommended fixes when integrating HDP 2.X Hadoop Sandbox and PolyBase.
1. PolyBase and Hadoop is not yet supported on HDI Hadoop (at the time of writing).

1. PolyBase only supports Hadoop from HortonWorks and Cloudera. For further information, see  [PolyBase Connectivity Configurations](https://msdn.microsoft.com/en-us/library/mt143174.aspx) for currently supported Hadoop versions.  

1. Create NameNode Checkpoint before restarting HDFS service from Ambari

	To avoid Namenode corruption and/or crash, it is best to put your Namenode(s) in safe mode before restarting HDFS service.  

	You may observe a similar **WARNING** like outlined below

	> The last HDFS checkpoint is older than 12 hours. Make sure that you have taken a checkpoint before proceeding. Otherwise, the NameNode(s) can take a very long time to start up.

	**FIX**  
	- Login to the NameNode host via ssh  

	- Put the NameNode in Safe Mode (read-only mode):  
	`sudo su hdfs -l -c 'hdfs dfsadmin -safemode enter'`  

	- Create a Checkpoint once in safemode:  
	`sudo su hdfs -l -c 'hdfs dfsadmin -saveNamespace'`

1. Changing the configuration on a service (for example YARN) requires the service and most often than not other affected services, like Zookeeper and Oozie, restarted as well.   
	Pay attention to the settings you have configured on these other services as one restart overwrites everything. For example, the general memory you have configured for Resource Manager alters the any memory changes in MapReduce2 as well, taking them back to default.  

	**FIX**  
 	See [Copy over configs to PolyBase](#copy-over-configs-to-polybase)

1. Unable to access Ambari WebUI as admin

	**FIX**  
	See [Activate access to Ambari](#activate-access-to-ambari) above.  

1. Unable to parse HDP version error
	```
		java.lang.IllegalArgumentException: Unable to parse '/hdp/apps/${hdp.version}/mapreduce/mapreduce.tar.gz#mr-framework' as a URI,\
	 check the setting for mapreduce.application.framework.path
	        at org.apache.hadoop.mapreduce.v2.util.MRApps.getMRFrameworkName(MRApps.java:181)
	        at org.apache.hadoop.mapreduce.v2.util.MRApps.setMRFrameworkClasspath(MRApps.java:206)
	        at org.apache.hadoop.mapreduce.v2.util.MRApps.setClasspath(MRApps.java:258)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl.getInitialClasspath(TaskAttemptImpl.java:621)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl.createCommonContainerLaunchContext(TaskAttemptImpl.java:757)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl.createContainerLaunchContext(TaskAttemptImpl.java:821)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl$ContainerAssignedTransition.transition(TaskAttemptImpl.java:1557)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl$ContainerAssignedTransition.transition(TaskAttemptImpl.java:1534)
	        at org.apache.hadoop.yarn.state.StateMachineFactory$SingleInternalArc.doTransition(StateMachineFactory.java:362)
	        at org.apache.hadoop.yarn.state.StateMachineFactory.doTransition(StateMachineFactory.java:302)
	        at org.apache.hadoop.yarn.state.StateMachineFactory.access$300(StateMachineFactory.java:46)
	        at org.apache.hadoop.yarn.state.StateMachineFactory$InternalStateMachine.doTransition(StateMachineFactory.java:448)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl.handle(TaskAttemptImpl.java:1084)
	        at org.apache.hadoop.mapreduce.v2.app.job.impl.TaskAttemptImpl.handle(TaskAttemptImpl.java:145)
	        at org.apache.hadoop.mapreduce.v2.app.MRAppMaster$TaskAttemptEventDispatcher.handle(MRAppMaster.java:1368)
	        at org.apache.hadoop.mapreduce.v2.app.MRAppMaster$TaskAttemptEventDispatcher.handle(MRAppMaster.java:1360)
	        at org.apache.hadoop.yarn.event.AsyncDispatcher.dispatch(AsyncDispatcher.java:183)
	        at org.apache.hadoop.yarn.event.AsyncDispatcher$1.run(AsyncDispatcher.java:109)
	        at java.lang.Thread.run(Thread.java:745)
	Caused by: java.net.URISyntaxException: Illegal character in path at index 11: /hdp/apps/${hdp.version}/mapreduce/mapreduce.tar.
	gz#mr-framework
	        at java.net.URI$Parser.fail(URI.java:2829)
	        at java.net.URI$Parser.checkChars(URI.java:3002)
	        at java.net.URI$Parser.parseHierarchical(URI.java:3086)
	        at java.net.URI$Parser.parse(URI.java:3044)
	      at java.net.URI.<init>(URI.java:595)
	        at org.apache.hadoop.mapreduce.v2.util.MRApps.getMRFrameworkName(MRApps.java:179)
	        ... 18 more
	```

	**FIX**  
		- Set `hdp.version` on SQL Server in PolyBase mapred-site.xml (_C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf_)  

			<property>
	 			<name>hdp.version</name>
 				<value>2.4.0.0-169</value>
 			</property>

1. Inability to query a Namenode in Safe mode  
	> Cannot execute the query "Remote Query" against OLE DB provider "SQLNCLI11" for linked server "(null)". EXTERNAL TABLE access failed due to internal error: 'Java exception raised on call to JobSubmitter_SubmitJob: Error [Cannot delete /user/pdw_user/.staging/job_1474057623050_0031. Name node is in safe mode.  

	**FIX**  
	- `sudo su hdfs -l -c 'hdfs dfsadmin -safemode leave'`  

