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
#wedatasphere全家桶一键启动脚本
source /home/hadoop/.bash_profile

function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

INSTALL_IP=186.137.170.60
echo "Please input your installed IP address"
read -p "Please input the IP: " ip
INSTALL_IP=$ip

sed -i "s/186.137.170.60/$INSTALL_IP/g" /wedatasphere/install/linkis/dss_appconn_instance.sql
sed -i "s/186.137.170.60/$INSTALL_IP/g" /wedatasphere/install/dss/conf/dss-workflow-server.properties
sed -i "s#127.0.0.1#$INSTALL_IP#g" /wedatasphere/install/qualitis-0.9.2/conf/application-dev.yml

#start mysql and nginx
echo "########################################################################"
echo "###################### Begin to start MySQL ###########################"
echo "########################################################################"
sudo service mysql restart
isSuccess "start MySQL"
sudo mysql -uroot -proot < /wedatasphere/install/linkis/dss_appconn_instance.sql

echo "########################################################################"
echo "###################### Begin to start nginx ###########################"
echo "########################################################################"
sudo /usr/sbin/nginx
isSuccess "start nginx"

echo "########################################################################"
echo "###################### Begin to start sshd ###########################"
echo "########################################################################"
sudo /usr/sbin/sshd -D &
isSuccess "start sshd"

echo "########################################################################"
echo "###################### Active env var and kinit#########################"
echo "########################################################################"
#active env var
source /wedatasphere/sbin/wedatasphere-env.sh
kinit -kt /wedatasphere/auth/hadoop.keytab hadoop
hdfs dfs -mkdir -p /tmp/linkis4/hadoop

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
cd /wedatasphere/install/schedulis/schedulis_0.7.1_exec/
bin/start-exec.sh
cd /wedatasphere/install/schedulis/schedulis_0.7.1_web/
bin/start-web.sh
isSuccess "start Schedulis"

echo "########################################################################"
echo "###################### Begin to start visualis ###########################"
echo "########################################################################"
sh /wedatasphere/install/visualis-server/bin/restart-visualis-server.sh
isSuccess "start visualis"

echo "########################################################################"
echo "###################### Begin to start qualitis ###########################"
echo "########################################################################"
sh /wedatasphere/install/qualitis-0.9.2/bin/start.sh
isSuccess "start qualitis"

echo "########################################################################"
echo "###################### Begin to start exchangis ###########################"
echo "########################################################################"
sh  /wedatasphere/install/exchangis/sbin/daemon.sh start server
isSuccess "start exchangis"

echo "########################################################################"
echo "###################### Begin to start streamis ###########################"
echo "########################################################################"
sh /wedatasphere/install/streamis/streamis-server/bin/start-streamis-server.sh
#isSuccess "start streamis"

echo "You can check all server by accessing eureka URL:http://$ip:8089"
tail -f /wedatasphere/install/linkis/logs/linkis-mg-eureka.log