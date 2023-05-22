#!/bin/sh
#Actively load user env

#把所有的安装路径为当前安装的根目录
function setCurrentRoot(){ 
  if [ "$LINKIS_HOME" = "" ]
  then
     export LINKIS_HOME=${LINKIS_DSS_HOME}/linkis
  fi
  if [ "$DSS_HOME" = "" ]
	then
	  export DSS_HOME=${LINKIS_DSS_HOME}/dss
  fi	
  if ! test -e ${LINKIS_HOME}; then
    sudo mkdir -p ${LINKIS_HOME};sudo chown -R $deployUser:$deployUser ${LINKIS_HOME}
  fi
  if ! test -e ${DSS_HOME}; then
    sudo mkdir -p ${DSS_HOME};sudo chown -R $deployUser:$deployUser ${DSS_HOME}
  fi
  DSS_INSTALL_HOME=$DSS_HOME
  ONE_CONGIN_PATH=${LINKIS_DSS_HOME}/conf/config.sh 
  sed -i  s#DSS_INSTALL_HOME=.*#DSS_INSTALL_HOME=${DSS_INSTALL_HOME}#g ${ONE_CONGIN_PATH}
  sed -i  s#LINKIS_HOME=.*#LINKIS_HOME=${LINKIS_HOME}#g ${ONE_CONGIN_PATH}

  ## eureka/gateway 使用系统明确的IP
  dss_ipaddr=$(hostname -I)
  dss_ipaddr=${dss_ipaddr// /}
  if [[ $LINKIS_EUREKA_INSTALL_IP == "127.0.0.1" ]] || [ -z "$LINKIS_EUREKA_INSTALL_IP" ]; then
     LINKIS_EUREKA_INSTALL_IP=${dss_ipaddr}
  fi
  if [[ $LINKIS_GATEWAY_INSTALL_IP == "127.0.0.1" ]] || [ -z "$LINKIS_GATEWAY_INSTALL_IP" ]; then
     LINKIS_GATEWAY_INSTALL_IP=${dss_ipaddr}
  fi  
  if [[ $DSS_NGINX_IP == "127.0.0.1" ]] || [ -z "$DSS_NGINX_IP" ]; then
    DSS_NGINX_IP=$dss_ipaddr
  fi  
}

function linkisReplace(){
  echo "Start to replace linkis field value."

  LINKIS_CONGIN_PATH=${TMP_LINKIS_FILE_PATH}/deploy-config/linkis-env.sh
  LINKIS_DB_PATH=${TMP_LINKIS_FILE_PATH}/deploy-config/db.sh
   
  ######################### replace linkis linkis-env.sh  start ###################################
  ######################### replace linkis linkis-env.sh  start ###################################
  
  ######################### db.sh  end ###################################
  sed -i  s#MYSQL_HOST=.*#MYSQL_HOST=${MYSQL_HOST}#g ${LINKIS_DB_PATH}
  sed -i  s#MYSQL_PORT=.*#MYSQL_PORT=${MYSQL_PORT}#g ${LINKIS_DB_PATH}
  sed -i  s#MYSQL_DB=.*#MYSQL_DB=${MYSQL_DB}#g ${LINKIS_DB_PATH}
  sed -i  s#MYSQL_USER=.*#MYSQL_USER=${MYSQL_USER}#g ${LINKIS_DB_PATH}
  sed -i  s#MYSQL_PASSWORD=.*#MYSQL_PASSWORD=${MYSQL_PASSWORD}#g ${LINKIS_DB_PATH}

  sed -i  s#deployUser.*#deployUser=${deployUser}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#LINKIS_VERSION=.*#LINKIS_VERSION=${LINKIS_VERSION}#g ${LINKIS_CONGIN_PATH}
  
  sed -i  s#WORKSPACE_USER_ROOT_PATH=.*#WORKSPACE_USER_ROOT_PATH=${WORKSPACE_USER_ROOT_PATH}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#HDFS_USER_ROOT_PATH=.*#HDFS_USER_ROOT_PATH=${HDFS_USER_ROOT_PATH}#g ${LINKIS_CONGIN_PATH}

  sed -i  s#ENGINECONN_ROOT_PATH=.*#ENGINECONN_ROOT_PATH=${ENGINECONN_ROOT_PATH}#g ${LINKIS_CONGIN_PATH}

  if [ "$ENTRANCE_CONFIG_LOG_PATH" != "" ]; then
    sed -i  s#.*ENTRANCE_CONFIG_LOG_PATH=.*#ENTRANCE_CONFIG_LOG_PATH=${ENTRANCE_CONFIG_LOG_PATH}#g ${LINKIS_CONGIN_PATH}
  fi  
  if [ "$RESULT_SET_ROOT_PATH" != "" ]; then
    sed -i  s#.*RESULT_SET_ROOT_PATH=.*#RESULT_SET_ROOT_PATH=${RESULT_SET_ROOT_PATH}#g ${LINKIS_CONGIN_PATH}
  fi
  
  ###Provide the DB information of Hive metadata database.
  HIVE_META_URL="jdbc:mysql://$HIVE_HOST:$HIVE_PORT/$HIVE_DB?useUnicode=true"  
  HIVE_META_USER=$HIVE_USER
  HIVE_META_PASSWORD=$HIVE_PASSWORD
  sed -i  s#HIVE_META_URL=.*#HIVE_META_URL=${HIVE_META_URL}#g ${LINKIS_DB_PATH}
  sed -i  s#HIVE_META_USER=.*#HIVE_META_USER=${HIVE_META_USER}#g ${LINKIS_DB_PATH}
  sed -i  s#HIVE_META_PASSWORD=.*#HIVE_META_PASSWORD=${HIVE_META_PASSWORD}#g ${LINKIS_DB_PATH}

  sed -i  s#YARN_RESTFUL_URL=.*#YARN_RESTFUL_URL=${YARN_RESTFUL_URL}#g ${LINKIS_CONGIN_PATH}
  
  sed -i  s#HADOOP_CONF_DIR=.*#HADOOP_CONF_DIR=${HADOOP_CONF_DIR}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#HIVE_CONF_DIR=.*#HIVE_CONF_DIR=${HIVE_CONF_DIR}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#SPARK_CONF_DIR=.*#SPARK_CONF_DIR=${SPARK_CONF_DIR}#g ${LINKIS_CONGIN_PATH}  
  sed -i  s#LINKIS_PUBLIC_MODULE=.*#LINKIS_PUBLIC_MODULE=${LINKIS_PUBLIC_MODULE}#g ${LINKIS_CONGIN_PATH}
  
  if [ "$SPARK_VERSION" != "" ]; then
    sed -i  s/#SPARK_VERSION=.*/SPARK_VERSION=${SPARK_VERSION}/g ${LINKIS_CONGIN_PATH}
  fi
  
  if [ "$HIVE_VERSION" != "" ]; then
    sed -i  s/#HIVE_VERSION=.*/HIVE_VERSION=${HIVE_VERSION}/g ${LINKIS_CONGIN_PATH}
  fi
  
  if [ "$PYTHON_VERSION" != "" ]; then
    sed -i  s/#PYTHON_VERSION=.*/PYTHON_VERSION=${PYTHON_VERSION}/g ${LINKIS_CONGIN_PATH}
  fi
  
  if [ "$LDAP_URL" != "" ]; then
	sed -i  s#.*LDAP_URL=.*#LDAP_URL=${LDAP_URL}#g ${LINKIS_CONGIN_PATH}
  fi  
  if [ "$LDAP_BASEDN" != "" ]; then
    sed -i  s/#LDAP_BASEDN=.*/LDAP_BASEDN=${LDAP_BASEDN}/g ${LINKIS_CONGIN_PATH}
  fi  
  if [ "$LDAP_USER_NAME_FORMAT" != "" ]; then
    sed -i  s/#LDAP_USER_NAME_FORMAT=.*/LDAP_USER_NAME_FORMAT=${LDAP_USER_NAME_FORMAT}/g ${LINKIS_CONGIN_PATH}
  fi

  ######################### replace linkis-env.sh [[linkis micro service]] start ###################################
  sed -i  "s#.*EUREKA_INSTALL_IP=127.*#EUREKA_INSTALL_IP=${LINKIS_EUREKA_INSTALL_IP}#g" ${LINKIS_CONGIN_PATH}
  sed -i  s#EUREKA_PORT=.*#EUREKA_PORT=${LINKIS_EUREKA_PORT}#g ${LINKIS_CONGIN_PATH} 	
  if [ "$LINKIS_EUREKA_PREFER_IP" != "" ]; then
    sed -i  "s#.*EUREKA_PREFER_IP=.*#EUREKA_PREFER_IP=${LINKIS_EUREKA_PREFER_IP}#g" ${LINKIS_CONGIN_PATH}
  fi

  sed -i  "s#.*GATEWAY_INSTALL_IP=.*#GATEWAY_INSTALL_IP=${LINKIS_GATEWAY_INSTALL_IP}#g" ${LINKIS_CONGIN_PATH}
  sed -i  s#GATEWAY_PORT=.*#GATEWAY_PORT=${LINKIS_GATEWAY_PORT}#g ${LINKIS_CONGIN_PATH}

  sed -i  s/#MANAGER_INSTALL_IP=.*/MANAGER_INSTALL_IP=${LINKIS_MANAGER_INSTALL_IP}/g ${LINKIS_CONGIN_PATH}
  sed -i  s#MANAGER_PORT=9101.*#MANAGER_PORT=${LINKIS_MANAGER_PORT}#g ${LINKIS_CONGIN_PATH}

  sed -i  s#.*ENGINECONNMANAGER_INSTALL_IP=.*#ENGINECONNMANAGER_INSTALL_IP=${LINKIS_ENGINECONNMANAGER_INSTALL_IP}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#ENGINECONNMANAGER_PORT=.*#ENGINECONNMANAGER_PORT=${LINKIS_ENGINECONNMANAGER_PORT}#g ${LINKIS_CONGIN_PATH}
  
  sed -i  s#.*ENGINECONN_PLUGIN_SERVER_INSTALL_IP=.*#ENGINECONN_PLUGIN_SERVER_INSTALL_IP=${LINKIS_ENGINECONN_PLUGIN_SERVER_INSTALL_IP}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#ENGINECONN_PLUGIN_SERVER_PORT=.*#ENGINECONN_PLUGIN_SERVER_PORT=${LINKIS_ENGINECONN_PLUGIN_SERVER_PORT}#g ${LINKIS_CONGIN_PATH}
  
  sed -i  s#.*ENTRANCE_INSTALL_IP=.*#ENTRANCE_INSTALL_IP=${LINKIS_ENTRANCE_INSTALL_IP}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#ENTRANCE_PORT=.*#ENTRANCE_PORT=${LINKIS_ENTRANCE_PORT}#g ${LINKIS_CONGIN_PATH}

  sed -i  s#.*PUBLICSERVICE_INSTALL_IP=.*#PUBLICSERVICE_INSTALL_IP=${LINKIS_PUBLICSERVICE_INSTALL_IP}#g ${LINKIS_CONGIN_PATH}
  sed -i  s#PUBLICSERVICE_PORT=.*#PUBLICSERVICE_PORT=${LINKIS_PUBLICSERVICE_PORT}#g ${LINKIS_CONGIN_PATH}
  
  if [ "$LINKIS_CS_INSTALL_IP" != "" ]; then
    sed -i  s#.*CS_INSTALL_IP=.*#CS_INSTALL_IP=${LINKIS_CS_INSTALL_IP}#g ${LINKIS_CONGIN_PATH}
  fi
  if [ "$LINKIS_CS_PORT" != "" ]; then
    sed -i  s#CS_PORT=.*#CS_PORT=${LINKIS_CS_PORT}#g ${LINKIS_CONGIN_PATH}
  fi  

  sed -i  s#LINKIS_HOME=.*#LINKIS_HOME=${LINKIS_HOME}#g ${LINKIS_CONGIN_PATH} 
  
  sed -i  s#SERVER_HEAP_SIZE=.*#SERVER_HEAP_SIZE=${SERVER_HEAP_SIZE}#g ${LINKIS_CONGIN_PATH}
  ######################### replace linkis-env.sh [[linkis micro service]] end ###################################  
  ######################### replace linkis linkis-env.sh  end ###################################
  ######################### replace linkis linkis-env.sh  end ###################################

  echo "End to replace linkis field value."
}



function dssReplace(){
  echo "Start to replace dss field value."   
  DSS_CONGIN_PATH=${TMP_DSS_FILE_PATH}/config/config.sh
  DSS_DB_PATH=${TMP_DSS_FILE_PATH}/config/db.sh
  ######################### replace dss config.sh  start ###################################
  ######################### replace dss config.sh  start ###################################  

  
  ######################### replace [[dss db.sh]]  start ###################################
  sed -i  s#MYSQL_HOST=.*#MYSQL_HOST=${MYSQL_HOST}#g ${DSS_DB_PATH}
  sed -i  s#MYSQL_PORT=.*#MYSQL_PORT=${MYSQL_PORT}#g ${DSS_DB_PATH}
  sed -i  s#MYSQL_DB=.*#MYSQL_DB=${MYSQL_DB}#g ${DSS_DB_PATH}
  sed -i  s#MYSQL_USER=.*#MYSQL_USER=${MYSQL_USER}#g ${DSS_DB_PATH}
  sed -i  s#MYSQL_PASSWORD=.*#MYSQL_PASSWORD=${MYSQL_PASSWORD}#g ${DSS_DB_PATH}  
  ######################### replace [[dss db.sh]]  end ###################################

  sed -i  s#deployUser=.*#deployUser=${deployUser}#g ${DSS_CONGIN_PATH}
  sed -i  s#SSH_PORT=.*#SSH_PORT=${SSH_PORT}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_INSTALL_HOME=.*#DSS_INSTALL_HOME=${DSS_INSTALL_HOME}#g ${DSS_CONGIN_PATH}   
   
  sed -i  "s#EUREKA_INSTALL_IP=.*#EUREKA_INSTALL_IP=${LINKIS_EUREKA_INSTALL_IP}#g" ${DSS_CONGIN_PATH}
  sed -i  s#EUREKA_PORT=.*#EUREKA_PORT=${LINKIS_EUREKA_PORT}#g ${DSS_CONGIN_PATH}
  sed -i  "s#GATEWAY_INSTALL_IP=.*#GATEWAY_INSTALL_IP=${LINKIS_GATEWAY_INSTALL_IP}#g" ${DSS_CONGIN_PATH}
  sed -i  s#GATEWAY_PORT=.*#GATEWAY_PORT=${LINKIS_GATEWAY_PORT}#g ${DSS_CONGIN_PATH}
  sed -i  s#WDS_SCHEDULER_PATH=.*#WDS_SCHEDULER_PATH=${WDS_SCHEDULER_PATH}#g ${DSS_CONGIN_PATH}

  ######################### replace config.sh [[dss micro service]] start ###################################
  sed -i  s#DSS_FRAMEWORK_PROJECT_SERVER_INSTALL_IP=.*#DSS_FRAMEWORK_PROJECT_SERVER_INSTALL_IP=${DSS_FRAMEWORK_PROJECT_SERVER_INSTALL_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_FRAMEWORK_PROJECT_SERVER_PORT=.*#DSS_FRAMEWORK_PROJECT_SERVER_PORT=${DSS_FRAMEWORK_PROJECT_SERVER_PORT}#g ${DSS_CONGIN_PATH}
  
  sed -i  s#DSS_FRAMEWORK_ORCHESTRATOR_SERVER_INSTALL_IP=.*#DSS_FRAMEWORK_ORCHESTRATOR_SERVER_INSTALL_IP=${DSS_FRAMEWORK_ORCHESTRATOR_SERVER_INSTALL_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_FRAMEWORK_ORCHESTRATOR_SERVER_PORT=.*#DSS_FRAMEWORK_ORCHESTRATOR_SERVER_PORT=${DSS_FRAMEWORK_ORCHESTRATOR_SERVER_PORT}#g ${DSS_CONGIN_PATH}
 
  sed -i  s#DSS_APISERVICE_SERVER_INSTALL_IP=.*#DSS_APISERVICE_SERVER_INSTALL_IP=${DSS_APISERVICE_SERVER_INSTALL_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_APISERVICE_SERVER_PORT=.*#DSS_APISERVICE_SERVER_PORT=${DSS_APISERVICE_SERVER_PORT}#g ${DSS_CONGIN_PATH}
  
  sed -i  s#DSS_WORKFLOW_SERVER_INSTALL_IP=.*#DSS_WORKFLOW_SERVER_INSTALL_IP=${DSS_WORKFLOW_SERVER_INSTALL_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_WORKFLOW_SERVER_PORT=.*#DSS_WORKFLOW_SERVER_PORT=${DSS_WORKFLOW_SERVER_PORT}#g ${DSS_CONGIN_PATH}
  
  sed -i  s#DSS_FLOW_EXECUTION_SERVER_INSTALL_IP=.*#DSS_FLOW_EXECUTION_SERVER_INSTALL_IP=${DSS_FLOW_EXECUTION_SERVER_INSTALL_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_FLOW_EXECUTION_SERVER_PORT=.*#DSS_FLOW_EXECUTION_SERVER_PORT=${DSS_FLOW_EXECUTION_SERVER_PORT}#g ${DSS_CONGIN_PATH}

  sed -i  s#DSS_DATAPIPE_SERVER_INSTALL_IP=.*#DSS_DATAPIPE_SERVER_INSTALL_IP=${DSS_DATAPIPE_SERVER_INSTALL_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_DATAPIPE_SERVER_PORT=.*#DSS_DATAPIPE_SERVER_PORT=${DSS_DATAPIPE_SERVER_PORT}#g ${DSS_CONGIN_PATH}
  ######################### replace config.sh [[dss micro service]] end ###################################  
 
 
  EVENTCHECKER_JDBC_URL="jdbc:mysql://$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DB?characterEncoding=UTF-8"
  EVENTCHECKER_JDBC_USERNAME=$MYSQL_USER
  EVENTCHECKER_JDBC_PASSWORD=$MYSQL_PASSWORD
  sed -i  s#EVENTCHECKER_JDBC_URL=.*#EVENTCHECKER_JDBC_URL=${EVENTCHECKER_JDBC_URL}#g ${DSS_CONGIN_PATH}
  sed -i  s#EVENTCHECKER_JDBC_USERNAME=.*#EVENTCHECKER_JDBC_USERNAME=${EVENTCHECKER_JDBC_USERNAME}#g ${DSS_CONGIN_PATH}
  sed -i  s#EVENTCHECKER_JDBC_PASSWORD=.*#EVENTCHECKER_JDBC_PASSWORD=${EVENTCHECKER_JDBC_PASSWORD}#g ${DSS_CONGIN_PATH}
  
  DATACHECKER_JOB_JDBC_URL="jdbc:mysql://$HIVE_HOST:$HIVE_PORT/$HIVE_DB?useUnicode=true"
  DATACHECKER_JOB_JDBC_USERNAME=$HIVE_USER
  DATACHECKER_JOB_JDBC_PASSWORD=$HIVE_PASSWORD
  sed -i  s#DATACHECKER_JOB_JDBC_URL=.*#DATACHECKER_JOB_JDBC_URL=${DATACHECKER_JOB_JDBC_URL}#g ${DSS_CONGIN_PATH}
  sed -i  s#DATACHECKER_JOB_JDBC_USERNAME=.*#DATACHECKER_JOB_JDBC_USERNAME=${DATACHECKER_JOB_JDBC_USERNAME}#g ${DSS_CONGIN_PATH}
  sed -i  s#DATACHECKER_JOB_JDBC_PASSWORD=.*#DATACHECKER_JOB_JDBC_PASSWORD=${DATACHECKER_JOB_JDBC_PASSWORD}#g ${DSS_CONGIN_PATH}
 
  DATACHECKER_BDP_JDBC_URL="jdbc:mysql://$HIVE_HOST:$HIVE_PORT/$HIVE_DB?useUnicode=true"
  DATACHECKER_BDP_JDBC_USERNAME=$HIVE_USER
  DATACHECKER_BDP_JDBC_PASSWORD=$HIVE_PASSWORD
  sed -i  s#DATACHECKER_BDP_JDBC_URL=.*#DATACHECKER_BDP_JDBC_URL=${DATACHECKER_BDP_JDBC_URL}#g ${DSS_CONGIN_PATH}
  sed -i  s#DATACHECKER_BDP_JDBC_USERNAME=.*#DATACHECKER_BDP_JDBC_USERNAME=${DATACHECKER_BDP_JDBC_USERNAME}#g ${DSS_CONGIN_PATH}
  sed -i  s#DATACHECKER_BDP_JDBC_PASSWORD=.*#DATACHECKER_BDP_JDBC_PASSWORD=${DATACHECKER_BDP_JDBC_PASSWORD}#g ${DSS_CONGIN_PATH}
  
  sed -i  s#BDP_MASK_IP=.*#BDP_MASK_IP=${BDP_MASK_IP}#g ${DSS_CONGIN_PATH}
  sed -i  s#BDP_MASK_PORT=.*#BDP_MASK_PORT=${BDP_MASK_PORT}#g ${DSS_CONGIN_PATH}
  
  sed -i  s#DSS_VERSION=.*#DSS_VERSION=${DSS_VERSION}#g ${DSS_CONGIN_PATH}
  sed -i  s#DSS_FILE_NAME=.*#DSS_FILE_NAME=${DSS_FILE_NAME}#g ${DSS_CONGIN_PATH}  
  
  sed -i  s#EMAIL_HOST=.*#EMAIL_HOST=${EMAIL_HOST}#g ${DSS_CONGIN_PATH} 
  sed -i  s#EMAIL_PORT=.*#EMAIL_PORT=${EMAIL_PORT}#g ${DSS_CONGIN_PATH} 
  sed -i  s#EMAIL_USERNAME=.*#EMAIL_USERNAME=${EMAIL_USERNAME}#g ${DSS_CONGIN_PATH} 
  sed -i  s#EMAIL_PASSWORD=.*#EMAIL_PASSWORD=${EMAIL_PASSWORD}#g ${DSS_CONGIN_PATH} 
  sed -i  s#EMAIL_PROTOCOL=.*#EMAIL_PROTOCOL=${EMAIL_PROTOCOL}#g ${DSS_CONGIN_PATH} 

  sed -i  s#SERVER_HEAP_SIZE=.*#SERVER_HEAP_SIZE=${SERVER_HEAP_SIZE}#g ${DSS_CONGIN_PATH}    

  EXCE_LOG_PATH=${TMP_DSS_FILE_PATH}/dss-$DSS_VERSION/conf/dss-framework-orchestrator-server.properties
  sed -i  s#wds.dss.server.export.url=.*#wds.dss.server.export.url=${ORCHESTRATOR_FILE_PATH}#g ${EXCE_LOG_PATH} 
  EXCE_LOG_PATH=${TMP_DSS_FILE_PATH}/dss-$DSS_VERSION/conf/dss-flow-execution-server.properties
  sed -i  s#wds.linkis.entrance.config.log.path=.*#wds.linkis.entrance.config.log.path=file://${EXECUTION_LOG_PATH}#g ${EXCE_LOG_PATH} 
  ######################### replace dss config.sh  end ###################################
  ######################### replace dss config.sh  end ###################################

  echo "End to replace dss field value."
}


function dssWebReplace(){
  echo "Start to replace dss web field value."
  DSS_WEB_CONGIN_PATH=${LINKIS_DSS_HOME}/web/config.sh
  LINKIS_GATEWAY_URL="http://${LINKIS_GATEWAY_INSTALL_IP}:${LINKIS_GATEWAY_PORT}"
  ######################### replace dss web config.sh start ###################################
  ######################### replace dss web config.sh start ###################################
  sed -i  "s#linkis_url.*#linkis_url=${LINKIS_GATEWAY_URL}#g" ${DSS_WEB_CONGIN_PATH}
  sed -i  s#dss_port.*#dss_port=${DSS_WEB_PORT}#g ${DSS_WEB_CONGIN_PATH}
  sed -i  "s#dss_ipaddr.*#dss_ipaddr=${DSS_NGINX_IP}#g" ${DSS_WEB_CONGIN_PATH}
  ######################### replace dss web config.sh end ###################################
  ######################### replace dss web config.sh end ###################################  
  echo "End to replace  dss web field value."
}






