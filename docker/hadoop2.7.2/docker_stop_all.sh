#!/bin/bash

function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

echo "########################################################################"
echo "###################### Begin to stop Schedulis ###########################"
echo "########################################################################"
cd /data/docker/Install/schedulis/schedulis-exec/
bin/shutdown-exec.sh
cd /data/docker/Install/schedulis/schedulis-web/
bin/shutdown-web.sh
isSuccess "stop Schedulis"

echo "########################################################################"
echo "###################### Begin to stop visualis ###########################"
echo "########################################################################"
sh /data/docker/Install/visualis/visualis-server/bin/stop-visualis-server.sh
isSuccess "stop visualis"

echo "########################################################################"
echo "###################### Begin to stop qualitis ###########################"
echo "########################################################################"
sh /data/docker/Install/qualitis/qualitis_dev/bin/stop.sh
isSuccess "stop qualitis"

echo "########################################################################"
echo "###################### Begin to stop exchangis ###########################"
echo "########################################################################"
cd /data/docker/Install/exchangis/background/sbin
./daemon.sh stop server
isSuccess "stop exchangis"

echo "########################################################################"
echo "###################### Begin to stop streamis ###########################"
echo "########################################################################"
sh /data/docker/Install/streamis/streamis-server/bin/stop-streamis-server.sh

echo "########################################################################"
echo "###################### Begin to stop DSS ###########################"
echo "########################################################################"
sh ${DSS_HOME}/sbin/dss-stop-all.sh
isSuccess "stop dss"

echo "########################################################################"
echo "###################### Begin to stop Linkis ###########################"
echo "########################################################################"
sh ${LINKIS_HOME}/sbin/linkis-stop-all.sh
isSuccess "stop linkis"

echo "########################################################################"
echo "###################### Begin to stop hive metastore ###########################"
echo "########################################################################"
hive --service metastore -stop

echo "###################### Begin to stop Hadoop ###########################"
echo "########################################################################"
sh ${HADOOP_HOME}/sbin/stop-all.sh
isSuccess "stop hadoop"

echo "########################################################################"
echo "###################### Begin to stop MySQL ###########################"
echo "########################################################################"
sudo /usr/local/mysql/support-files/mysql.server stop
isSuccess "stop MySQL"


echo "########################################################################"
echo "###################### Begin to stop nginx ###########################"
echo "########################################################################"
sudo nginx -s stop
