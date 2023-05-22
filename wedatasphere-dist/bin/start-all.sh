#!/bin/sh
#Actively load user env

#source ~/.bash_profile

if [ -f "~/.bashrc" ];then
  echo "Warning! user bashrc file does not exist."
else
  source ~/.bashrc
fi

shellDir=`dirname $0`
LINKIS_DSS_HOME=`cd ${shellDir}/..;pwd`

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
echo "###################### Begin to start Linkis ###########################"
echo "########################################################################"
sh ${LINKIS_HOME}/sbin/linkis-start-all.sh
isSuccess "start Linkis"

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start DSS Service ######################"
echo "########################################################################"
sh ${DSS_HOME}/sbin/dss-start-all.sh
isSuccess "start DSS Service"

echo ""
echo ""
echo "########################################################################"
echo "###################### Begin to start DSS & Linkis web ##########################"
echo "########################################################################"

dss_ipaddr=$(hostname -I)
dss_ipaddr=${dss_ipaddr// /}

function startDssWeb(){
version=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
# centos 6
if [[ $version -eq 6 ]]; then
    sudo /etc/init.d/nginx start
    isSuccess "start DSS & Linkis Web"
fi

# centos 7
if [[ $version -eq 7 ]]; then
    sudo systemctl start nginx
    isSuccess "start DSS & Linkis Web"
fi
}
startDssWeb

if [[ $LINKIS_EUREKA_INSTALL_IP == "127.0.0.1" ]] || [ -z "$LINKIS_EUREKA_INSTALL_IP" ]; then
 LINKIS_EUREKA_INSTALL_IP=${dss_ipaddr}
fi

echo ""
echo "==============================================="
echo "There are eight micro services in Linkis："
echo "linkis-cg-engineconnmanager"
echo "linkis-cg-engineplugin"
echo "linkis-cg-entrance"
echo "linkis-cg-linkismanager"
echo "linkis-mg-eureka"
echo "linkis-mg-gateway"
echo "linkis-ps-cs"
echo "linkis-ps-publicservice"
echo "-----------------------------------------------"
echo "There are six micro services in DSS：" 
echo "dss-framework-project-server"
echo "dss-framework-orchestrator-server-dev"
echo "dss-workflow-server-dev"
echo "dss-flow-entrance"
echo "dss-datapipe-server"
echo "dss-apiservice-server"
echo "==============================================="
echo ""
echo "Log path of Linkis: linkis/logs"
echo "Log path of DSS : dss/logs"

echo ""
echo "You can check DSS & Linkis by acessing eureka URL: http://${LINKIS_EUREKA_INSTALL_IP}:${LINKIS_EUREKA_PORT}"
echo "You can acess DSS & Linkis Web by http://${dss_ipaddr}:${DSS_WEB_PORT}"
echo ""
 