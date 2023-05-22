### deploy user
deployUser=hadoop

## max memory for services
SERVER_HEAP_SIZE=512M

### The install home path of DSS，Must provided
DSS_INSTALL_HOME=/wedatasphere/install/dss

DSS_VERSION=1.1.1

DSS_FILE_NAME=dss-1.1.1

###  Linkis EUREKA  information.  # Microservices Service Registration Discovery Center
EUREKA_INSTALL_IP=wds
EUREKA_PORT=9600
### If EUREKA  has safety verification, please fill in username and password
#EUREKA_USERNAME=
#EUREKA_PASSWORD=

### Linkis Gateway  information
GATEWAY_INSTALL_IP=wds
GATEWAY_PORT=9001

################### The install Configuration of all Micro-Services #####################
#
#    NOTICE:
#       1. If you just wanna try, the following micro-service configuration can be set without any settings.
#            These services will be installed by default on this machine.
#       2. In order to get the most complete enterprise-level features, we strongly recommend that you install
#          the following microservice parameters
#

### DSS_SERVER
### This service is used to provide dss-server capability.

### project-server
DSS_FRAMEWORK_PROJECT_SERVER_INSTALL_IP=wds
DSS_FRAMEWORK_PROJECT_SERVER_PORT=9002
### orchestrator-server
DSS_FRAMEWORK_ORCHESTRATOR_SERVER_INSTALL_IP=wds
DSS_FRAMEWORK_ORCHESTRATOR_SERVER_PORT=9003
### apiservice-server
DSS_APISERVICE_SERVER_INSTALL_IP=wds
DSS_APISERVICE_SERVER_PORT=9004
### dss-workflow-server
DSS_WORKFLOW_SERVER_INSTALL_IP=wds
DSS_WORKFLOW_SERVER_PORT=9005
### dss-flow-execution-server
DSS_FLOW_EXECUTION_SERVER_INSTALL_IP=wds
DSS_FLOW_EXECUTION_SERVER_PORT=9006
###dss-scriptis-server
DSS_SCRIPTIS_SERVER_INSTALL_IP=wds
DSS_SCRIPTIS_SERVER_PORT=9008

###dss-data-api-server
DSS_DATA_API_SERVER_INSTALL_IP=wds
DSS_DATA_API_SERVER_PORT=9208
###dss-data-governance-server
DSS_DATA_GOVERNANCE_SERVER_INSTALL_IP=wds
DSS_DATA_GOVERNANCE_SERVER_PORT=9209
###dss-guide-server
DSS_GUIDE_SERVER_INSTALL_IP=wds
DSS_GUIDE_SERVER_PORT=9210

############## ############## dss_appconn_instance configuration   start   ############## ##############
####eventchecker表的地址，一般就是dss数据
EVENTCHECKER_JDBC_URL=jdbc:mysql://wds:3306/linkis?characterEncoding=UTF-8
EVENTCHECKER_JDBC_USERNAME=linkis
EVENTCHECKER_JDBC_PASSWORD=linkis

#### hive地址
DATACHECKER_JOB_JDBC_URL=jdbc:mysql://cdhdev01.gzcb.com.cn:3306/metastore?useUnicode=true
DATACHECKER_JOB_JDBC_USERNAME=hive
DATACHECKER_JOB_JDBC_PASSWORD=password
#### 元数据库，可配置成和DATACHECKER_JOB
DATACHECKER_BDP_JDBC_URL=jdbc:mysql://cdhdev01.gzcb.com.cn:3306/metastore?useUnicode=true
DATACHECKER_BDP_JDBC_USERNAME=hive
DATACHECKER_BDP_JDBC_PASSWORD=password
############## ############## dss_appconn_instance configuration   end   ############## ##############