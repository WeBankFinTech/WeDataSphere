#!/bin/sh
#
# Copyright 2019 WeBank
#
# Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

shellDir=`dirname $0`

LINKIS_DSS_HOME=`cd ${shellDir}/..;pwd`

# set default conf value
export deployUser=`whoami`

source ${LINKIS_DSS_HOME}/conf/config.sh 

err() {
    printf 'Failed to execute command \n %s\n' "$1"
    exit 1
}

function isSuccess(){
if [ $? -ne 0 ]; then
    err $1
else
    echo "Succeed to" + $1
fi
}

executeUser=$deployUser

mkdir_dir() {
dir=$1
## mkdir
sudo mkdir -p $dir
## chmod 775
sudo chmod -R  775 $dir
## chown user
sudo chown $executeUser $dir
}

#1.create required dir
echo "<-----start to create required dir ---->"

mkdir_dir $ENGINECONN_ROOT_PATH

echo "<-----Finished to create required dir ---->"

##2. check hadoop/spark/hive/sqoop/python/java
check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (your linux command not found)"
    fi
}

echo "<-----start to check used cmd---->"
need_cmd java
need_cmd mysql
need_cmd telnet
need_cmd tar
need_cmd sed
need_cmd spark-sql
need_cmd hdfs
need_cmd hive
need_cmd python
need_cmd dos2unix
echo "<-----end to check used cmd---->"

##1. to execute hadoop/hive/spark-sql/python
function sudoSuexecuteCMD(){
   user=$1
   cmd=$2
   eval "sudo su - $user -c \"$2\""
   isSuccess "user $user execute $cmd"
}
sudoSuexecuteCMD $executeUser "hdfs dfs -ls /"
sudoSuexecuteCMD $executeUser "python -c 'import matplotlib' "
sudoSuexecuteCMD $executeUser "hive -e 'show tables' "
echo "<-----Finished to check env---->"