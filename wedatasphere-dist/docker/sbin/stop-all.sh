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
#wedatasphere 全家桶一键停止脚本
source /home/hadoop/.bash_profile

function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

echo "########################################################################"
echo "###################### Active env var and kinit#########################"
echo "########################################################################"
#active env var
source /wedatasphere/sbin/wedatasphere-env.sh
kinit -kt /wedatasphere/auth/hadoop.keytab hadoop

echo "########################################################################"
echo "###################### Begin to stop Schedulis ###########################"
echo "########################################################################"
cd /wedatasphere/install/schedulis/schedulis_0.7.1_exec
bin/shutdown-exec.sh
cd /wedatasphere/install/schedulis/schedulis_0.7.1_web/
bin/shutdown-web.sh
isSuccess "stop Schedulis"

echo "########################################################################"
echo "###################### Begin to stop visualis ###########################"
echo "########################################################################"
sh /wedatasphere/install/visualis-server/bin/stop-visualis-server.sh
isSuccess "stop visualis"

echo "########################################################################"
echo "###################### Begin to stop qualitis ###########################"
echo "########################################################################"
sh /wedatasphere/install/qualitis-0.9.2/bin/stop.sh
isSuccess "stop qualitis"

echo "########################################################################"
echo "###################### Begin to stop exchangis ###########################"
echo "########################################################################"
cd /wedatasphere/install/exchangis/sbin/
./daemon.sh stop server
isSuccess "stop exchangis"

echo "########################################################################"
echo "###################### Begin to stop streamis ###########################"
echo "########################################################################"
sh /wedatasphere/install/streamis/streamis-server/bin/stop-streamis-server.sh

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
echo "###################### Begin to stop MySQL ###########################"
echo "########################################################################"
sudo service mysql stop
isSuccess "stop MySQL"

echo "########################################################################"
echo "###################### Begin to stop nginx ###########################"
echo "########################################################################"
sudo /usr/sbin/nginx -s stop
isSuccess "stop nginx"

for pid in $(jps -v); do kill -9 $pid; done