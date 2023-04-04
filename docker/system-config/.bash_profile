# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
export CDH_HOME=/opt/cloudera/parcels/CDH
export JAVA_HOME=/usr/java/jdk1.8.0_181-cloudera
export SPARK_HOME=/wedatasphere/install/spark-2.4.3-bin-hadoop2.6
export SPARK_CONF_DIR=/wedatasphere/install/spark-2.4.3-bin-hadoop2.6/conf
export HIVE_HOME=/opt/cloudera/parcels/CDH/lib/hive
export HIVE_CONF_DIR=/etc/hive/conf
export HADOOP_HOME=/opt/cloudera/parcels/CDH/lib/hadoop
export HADOOP_CONF_DIR=/etc/hadoop/conf
export SQOOP_HOME=/wedatasphere/install/sqoop-1.4.6.bin__hadoop-2.0.4-alpha
export SQOOP_CONF_DIR=/wedatasphere/install/sqoop-1.4.6.bin__hadoop-2.0.4-alpha/conf
export STREAMIS_INSTALL_HOME=/wedatasphere/install/streamis
export EXCHANGIS_HOME=/wedatasphere/install/exchangis
export PYSPARK_ALLOW_INSECURE_GATEWAY=1
export PATH=$SQOOP_HOME/bin:$JAVA_HOME/bin:$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:$CDH_HOME/bin
export HADOOP_CLASSPATH=`hadoop classpath`