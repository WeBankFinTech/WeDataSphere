#!/bin/bash
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
kinit -kt /wedatasphere/auth/hadoop.keytab hadoop
hdfs dfs -mkdir -p /tmp/linkis4/hadoop
sudo /usr/sbin/sshd -D &
sudo service mysql restart
sudo /usr/sbin/nginx
sh /wedatasphere/install/linkis/sbin/linkis-start-all.sh
sh /wedatasphere/install/dss/sbin/dss-start-all.sh
cd /wedatasphere/install/schedulis/schedulis_0.7.1_exec/
bin/start-exec.sh
cd /wedatasphere/install/schedulis/schedulis_0.7.1_web/
bin/start-web.sh
sh /wedatasphere/install/visualis-server/bin/restart-visualis-server.sh
sh /wedatasphere/install/qualitis-0.9.2/bin/start.sh
cd  /wedatasphere/install/exchangis/sbin/
./daemon.sh restart server
sh /wedatasphere/install/streamis/streamis-server/bin/start-streamis-server.sh
tail -f /wedatasphere/install/linkis/logs/linkis-mg-eureka.log