<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration xmlns:xi="http://www.w3.org/2001/XInclude">
  
  <!-- This should match the value from HDI at /usr/hdp/{version} -->
  <property>
    <name>hdp.version</name>
    <value>$(HDP_VERSION)</value>
	</property>
	
	<!-- These should match the values from HDI at $HADOOP_CONF_DIR/mapred-site.xml -->
	<property>
    <name>mapreduce.application.classpath</name>
    <value>$PWD/mr-framework/hadoop/share/hadoop/mapreduce/*:$PWD/mr-framework/hadoop/share/hadoop/mapreduce/lib/*:$PWD/mr-framework/hadoop/share/hadoop/common/*:$PWD/mr-framework/hadoop/share/hadoop/common/lib/*:$PWD/mr-framework/hadoop/share/hadoop/yarn/*:$PWD/mr-framework/hadoop/share/hadoop/yarn/lib/*:$PWD/mr-framework/hadoop/share/hadoop/hdfs/*:$PWD/mr-framework/hadoop/share/hadoop/hdfs/lib/*:$PWD/mr-framework/hadoop/share/hadoop/tools/lib/*:/usr/hdp/${hdp.version}/hadoop/lib/hadoop-lzo-0.6.0.${hdp.version}.jar:/etc/hadoop/conf/secure</value>
	</property>
	<property>
    <name>mapreduce.application.framework.path</name>
    <value>/hdp/apps/${hdp.version}/mapreduce/mapreduce.tar.gz#mr-framework</value>
	</property>
	
	 <!-- Required by PolyBase -->
  <property>
    <name>mapred.min.split.size</name>
    <value>1073741824</value>
  </property>
  <property>
    <name>mapreduce.app-submission.cross-platform</name>
    <value>true</value>
  </property>

  <!--kerberos security information, PLEASE FILL THESE IN ACCORDING TO HADOOP CLUSTER CONFIG
    <property>
      <name>mapreduce.jobhistory.principal</name>
      <value></value>
    </property>
    <property>
      <name>mapreduce.jobhistory.address</name>
      <value></value>
    </property>
  -->
</configuration>