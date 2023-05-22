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
#wedatasphere 全家桶一键停止脚本
source /home/hadoop/.bash_profile
kinit -kt /wedatasphere/auth/hadoop.keytab hadoop
sh /wedatasphere/install/linkis/sbin/linkis-stop-all.sh
sh /wedatasphere/install/dss/sbin/dss-stop-all.sh
sh /wedatasphere/install/schedulis/schedulis_0.7.1_exec/bin/shutdown-exec.sh
sh /wedatasphere/install/schedulis/schedulis_0.7.1_web/bin/shutdown-web.sh
sudo /usr/sbin/nginx -s stop
sh /wedatasphere/install/visualis-server/bin/stop-visualis-server.sh
sh /wedatasphere/install/qualitis-0.9.2/bin/stop.sh
cd /wedatasphere/install/exchangis/sbin/
./daemon.sh stop server
sh /wedatasphere/install/streamis/streamis-server/bin/stop-streamis-server.sh
sudo service mysql stop