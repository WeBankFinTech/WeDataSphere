#!/bin/bash

source ~/.bashrc
function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

INSTALL_IP=127.0.0.1
echo "Please input your installed IP address"
read -p "Please input the IP: " ip
INSTALL_IP=$ip

sed -i "s/127.0.0.1/$INSTALL_IP/g" /data/docker/dss_appconn_instance.sql
sed -i "s/127.0.0.1/$INSTALL_IP/g" /data/docker/config/dss-config/dss-workflow-server.properties

#start mysql and nginx
echo "########################################################################"
echo "###################### Begin to start MySQL ###########################"
echo "########################################################################"
sudo /usr/local/mysql/support-files/mysql.server start
isSuccess "start MySQL"
sudo mysql -uroot -pbdp@2023 < /data/docker/dss_appconn_instance.sql

echo "########################################################################"
echo "###################### Begin to start nginx ###########################"
echo "########################################################################"
sudo nginx
isSuccess "start nginx"


echo "########################################################################"
echo "###################### Active env var ###########################"
echo "########################################################################"
#active env var
source /data/docker/config/env.sh

echo "########################################################################"
echo "###################### Begin to start Hadoop ###########################"
echo "########################################################################"
#start hadoop
sh ${HADOOP_HOME}/sbin/start-all.sh
isSuccess "start hadoop"


echo "########################################################################"
echo "###################### Begin to start hive metastore ###########################"
echo "########################################################################"
hive --service metastore &

echo "########################################################################"
echo "###################### Begin to start Linkis ###########################"
echo "########################################################################"
#start linkis
sh ${LINKIS_HOME}/sbin/linkis-start-all.sh
isSuccess "start linkis"

echo "########################################################################"
echo "###################### Begin to start DSS ###########################"
echo "########################################################################"
#start dss
sh ${DSS_HOME}/sbin/dss-start-all.sh
isSuccess "start dss"

echo "########################################################################"
echo "###################### Begin to start Schedulis ###########################"
echo "########################################################################"
echo `hostname`=1 > /data/docker/config/schedulis-config/host.properties
sudo cp /data/docker/commonlib/derby.jar /data/docker/Install/schedulis/schedulis-web/lib/
sudo cp /data/docker/commonlib/derby.jar /data/docker/Install/schedulis/schedulis-exec/lib/
cd /data/docker/Install/schedulis/schedulis-exec/
bin/start-exec.sh
cd /data/docker/Install/schedulis/schedulis-web/
bin/start-web.sh
isSuccess "start Schedulis"

echo "########################################################################"
echo "###################### Begin to start visualis ###########################"
echo "########################################################################"
sh /data/docker/Install/visualis/visualis-server/bin/start-visualis-server.sh
isSuccess "start visualis"

echo "########################################################################"
echo "###################### Begin to start qualitis ###########################"
echo "########################################################################"
sh /data/docker/Install/qualitis/qualitis_dev/bin/start.sh
isSuccess "start qualitis"

echo "########################################################################"
echo "###################### Begin to start exchangis ###########################"
echo "########################################################################"
sh /data/docker/Install/exchangis/background/sbin/daemon.sh start server
isSuccess "start exchangis"

echo "########################################################################"
echo "###################### Begin to start streamis ###########################"
echo "########################################################################"
sh /data/docker/Install/streamis/streamis-server/bin/start-streamis-server.sh

echo "You can check all server by acessing eureka URL:http://ip:8087"
