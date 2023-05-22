#!/bin/sh
#Actively load user env

if [ -f "~/.bashrc" ];then
  echo "Warning! user bashrc file does not exist."
else
  source ~/.bashrc
fi

shellDir=`dirname $0`
export LINKIS_DSS_HOME=`cd ${shellDir}/..;pwd`

function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    exit 1
else
    echo "Succeed to" + $1
fi
}

source ${LINKIS_DSS_HOME}/conf/config.sh
source ${LINKIS_DSS_HOME}/conf/db.sh
source ${LINKIS_DSS_HOME}/bin/replace.sh
#######设置为当前路径，如果不需要直接注掉这执行函数##########
setCurrentRoot

echo "########################################################################"
echo "###################### Begin to stop Linkis ############################"
echo "########################################################################"
sh ${LINKIS_HOME}/sbin/linkis-stop-all.sh
isSuccess "stop Linkis"

 
echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to stop DSS Service #######################"
echo "########################################################################"
sh ${DSS_HOME}/sbin/dss-stop-all.sh
isSuccess "stop DSS Service"

echo "" 
echo ""
echo "########################################################################"
echo "###################### Begin to stop DSS & Linkis Web ###########################"
echo "########################################################################"
function stopDssWeb(){
version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
# centos 6
if [[ $version -eq 6 ]]; then
    sudo /etc/init.d/nginx stop
    isSuccess "stop DSS & Linkis Web"
fi

# centos 7
if [[ $version -eq 7 ]]; then
    sudo systemctl stop nginx
    isSuccess "stop DSS & Linkis Web"
fi 
}
stopDssWeb

