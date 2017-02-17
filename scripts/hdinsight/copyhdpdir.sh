#!/usr/bin/env bash

function get_active_namenode
{
	ha_name=mycluster # Hard code cluster name
	ha_ns_nodes=$(hdfs getconf -confKey dfs.ha.namenodes.${ha_name})
	active=""
	for node in $(echo ${ha_ns_nodes//,/ }); do
		state=$(hdfs haadmin -getServiceState $node)
		if [ "$state" == "active" ]; then
			active=$(hdfs getconf -confKey dfs.namenode.rpc-address.${ha_name}.${node})
			break
		fi
	done
	if [ -z "$active" ]; then
		>&2 echo "ERROR: no active namenode found for ${ha_name}"
		exit 1
	else
		echo $active
	fi
}

function is_active_namenode
{
	my_fqdn=`hostname -f`
	activenamenode=`get_active_namenode`
	activenamenode_fqdn=`echo $activenamenode | cut -d ':' -f 1`
	if [ $my_fqdn == $activenamenode_fqdn ]; then
		echo 1;
	else
		echo 0;
	fi
}

# Check if the current host is active namenode
if [ `is_active_namenode` == 0 ]; then
        echo "Only copy hdp on active namenode, exiting ..."
        exit 0
fi

# Copy the hdp directory from HDFS to local
hdfs dfs -cp /hdp hdfs://$(hostname)/hdp