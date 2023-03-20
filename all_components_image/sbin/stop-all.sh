#!/bin/sh
#Actively load user env

if [ -f "~/.bashrc" ];then
  echo "Warning! user bashrc file does not exist."
else
  source ~/.bashrc
fi

shellDir=`dirname $0`
export LINKIS_DSS_HOME=`cd ${shellDir}/../install/dss_linkis;pwd`

function isSuccess(){
if [ $? -ne 0 ]; then
    echo "Failed to " + $1
    # exit 1
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
echo "###################### Begin to stop DSS & Linkis Web ##################"
echo "########################################################################"
function stopDssWeb(){
version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
# centos 6
if [[ $version -eq 6 ]]; then
    # sudo /etc/init.d/nginx stop
    isSuccess "stop DSS & Linkis Web"
fi

# centos 7
if [[ $version -eq 7 ]]; then
    # sudo systemctl stop nginx
    isSuccess "stop DSS & Linkis Web"
fi
}
stopDssWeb


echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start Qualitis##########################"
echo "########################################################################"

export QUALITIS_HOME=`cd ${shellDir}/../install/qualitis;pwd`

sh ${QUALITIS_HOME}/bin/stop.sh
isSuccess "stop Qualitis"

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start Exchangis#########################"
echo "########################################################################"

export EXCHANGIS_HOME=`cd ${shellDir}/../install/exchangis;pwd`

sh ${EXCHANGIS_HOME}/sbin/daemon.sh stop server
isSuccess "stop Exchangis"

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start Visualis##########################"
echo "########################################################################"

export VISUALIS_HOME=`cd ${shellDir}/../install/visualis;pwd`

sh ${VISUALIS_HOME}/bin/stop-visualis-server.sh
isSuccess "stop Visualis"


echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start Schedulis#########################"
echo "########################################################################"

export SCHEDULIS_HOME=`cd ${shellDir}/../install/schedulis;pwd`


cd ${SCHEDULIS_HOME}/schedulis_0.7.1_exec && sh bin/shutdown-exec.sh
isSuccess "start SchedulisExec"

cd ${SCHEDULIS_HOME}/schedulis_0.7.1_web && sh bin/shutdown-web.sh
isSuccess "start SchedulisWeb"

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start Streamis##########################"
echo "########################################################################"

export STREAMIS_HOME=`cd ${shellDir}/../install/streamis/streamis-server;pwd`

sh ${STREAMIS_HOME}/bin/stop-streamis-server.sh
isSuccess "stop Streamis"