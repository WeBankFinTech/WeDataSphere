#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#wedatasphere 全家桶环境变量配置脚本
LINKIS_HOME=/wedatasphere/install/linkis
LINKIS_PLUGINS_PATH=${LINKIS_HOME}/lib/linkis-engineconn-plugins
EXCHANGIS_HOME=/wedatasphere/install/exchangis
STREAMIS_INSTALL_HOME=/wedatasphere/install/streamis
DSS_HOME=/wedatasphere/install/dss
DSS_WEB_ROOT=/wedatasphere/install/web
LINKIS_WEB_ROOT=/wedatasphere/install/web/dss/linkis
LINKIS_CONF_DIR=${LINKIS_HOME}/conf
LINKIS_LOG_DIR=${LINKIS_HOME}/logs
WORKSPACE_USER_ROOT_PATH=/wedatasphere/workspace
HDFS_USER_ROOT_PATH=/tmp/linkis4
ENGINECONN_ROOT_PATH=/wedatasphere/logs
JAVA_HOME=/wedatasphere/install/jdk1.8.0_361
hadoopVersion=2.6.0-cdh5.16.1
HADOOP_HOME=/opt/cloudera/parcels/CDH/lib/hadoop
HADOOP_CONF_DIR=/wedatasphere/config/hadoop-config
YARN_RESTFUL_URL=http://cdhdev02.gzcb.com.cn
HIVE_HOME=/opt/cloudera/parcels/CDH/lib/hive
HIVE_CONF_DIR=/wedatasphere/config/hive-config
HADOOP_CLASSPATH=`hadoop classpath`
HIVE_META_URL=jdbc:mysql://cdhdev01.gzcb.com.cn:3306/metastore?useUnicode=true
HIVE_META_USER=hive
HIVE_META_PASSWORD=password
SPARK_HOME=/wedatasphere/install/spark-2.4.3-bin-hadoop2.6
SPARK_CONF_DIR=${SPARK_HOME}/conf
FLINK_HOME=/wedatasphere/install/flink-1.12.2
FLINK_CONF_DIR=${FLINK_HOME}/conf
FLINK_LIB_DIR=${FLINK_HOME}/lib
SQOOP_HOME=/wedatasphere/install/sqoop-1.4.6.bin__hadoop-2.0.4-alpha
SQOOP_CONF_DIR=${SQOOP_HOME}/conf
HCAT_HOME=
PYTHON_HOME=/usr
PYSPARK_ALLOW_INSECURE_GATEWAY=1
ENABLE_METADATA_QUERY=true
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DB=linkis
MYSQL_USER=linkis
MYSQL_PASSWORD=linkis