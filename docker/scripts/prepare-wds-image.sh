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
#
WORK_DIR=`cd $(dirname $0); pwd -P`
. ${WORK_DIR}/utils.sh

WDS_TAR_DIR=${PROJECT_TARGET}/docker/wds-tars

mkdir -p ${TAR_CACHE_ROOT}
rm -rf ${WDS_TAR_DIR} && mkdir -p ${WDS_TAR_DIR}

#rm -rf ${PROJECT_TARGET}/entry-point-ldh.sh
#cp ${WORK_DIR}/entry-point-ldh.sh ${PROJECT_TARGET}/

SPARK_VERSION=${SPARK_VERSION:-2.4.3}
SPARK_HADOOP_VERSION=${SPARK_HADOOP_VERSION:-2.6}
FLINK_VERSION=${FLINK_VERSION:-1.12.2}
SQOOP_VERSION=${SQOOP_VERSION:-1.4.6}
VISUALIS_VERSION=${VISUALIS_VERSION:-1.0.0}
EXCHANGIS_VERSION=${EXCHANGIS_VERSION:-1.0.0}
SCHEDULIS_VERSION=${SCHEDULIS_VERSION:-0.7.1}
STREAMIS_VERSION=${STREAMIS_VERSION:-0.2.0}
QUALITIS_VERSION=${QUALITIS_VERSION:-0.9.2}
DSS_VERSION=${DSS_VERSION:-1.1.1}
MYSQL_JDBC_VERSION=${MYSQL_JDBC_VERSION:-8.0.16}
MYSQL_VERSION=${MYSQL_VERSION:-5.7.36}

set -e

echo "# Tars for hadoop component will be cached to: ${TAR_CACHE_ROOT}"
TARFILENAME_SPARK="spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz"
TARFILENAME_FLINK="flink-${FLINK_VERSION}-bin-scala_2.11.tgz"
TARFILENAME_SQOOP="sqoop-${SQOOP_VERSION}.bin__hadoop-2.0.4-alpha.tar.gz"
TARFILENAME_VISUALIS="visualis_${VISUALIS_VERSION}_install_package.zip"
TARFILENAME_EXCHANGIS="wedatasphere-exchangis-${EXCHANGIS_VERSION}.tar.gz"
TARFILENAME_EXCHANGIS_WEB="dist.zip"
TARFILENAME_SCHEDULIS_EXEC="schedulis_${SCHEDULIS_VERSION}_exec.zip"
TARFILENAME_SCHEDULIS_WEB="schedulis_${SCHEDULIS_VERSION}_web.zip"
TARFILENAME_STREAMIS="wedatasphere-streamis-${STREAMIS_VERSION}-dist.tar.gz"
TARFILENAME_STREAMIS_WEB="streamis-${STREAMIS_VERSION}-dist.zip"
TARFILENAME_QUALITIS="qualitis-${QUALITIS_VERSION}.zip"
TARFILENAME_DSS="wedatasphere-dss-${DSS_VERSION}-dist.tar.gz"
TARFILENAME_DSS_WEB="wedatasphere-dss-web-${DSS_VERSION}-dist.zip"
TARFILENAME_MYSQL_JDBC=mysql-connector-java-${MYSQL_JDBC_VERSION}.jar
TARFILENAME_MYSQL=mysql-${MYSQL_VERSION}-el7-x86_64.tar.gz

DOWNLOAD_URL_SPARK="https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${TARFILENAME_SPARK}"
DOWNLOAD_URL_FLINK="https://archive.apache.org/dist/flink/flink-${FLINK_VERSION}/${TARFILENAME_FLINK}"
DOWNLOAD_URL_SQOOP="https://archive.apache.org/dist/sqoop/${SQOOP_VERSION}/${TARFILENAME_SQOOP}"
DOWNLOAD_URL_VISUALIS="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/Visualis/${TARFILENAME_VISUALIS}"
DOWNLOAD_URL_EXCHANGIS="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/Exchangis/exchangis${EXCHANGIS_VERSION}/${TARFILENAME_EXCHANGIS}"
DOWNLOAD_URL_EXCHANGIS_WEB="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/Exchangis/exchangis${EXCHANGIS_VERSION}/${TARFILENAME_EXCHANGIS_WEB}"
DOWNLOAD_URL_SCHEDULIS_EXEC="https://github.com/WeBankFinTech/Schedulis/releases/download/release-${SCHEDULIS_VERSION}/${TARFILENAME_SCHEDULIS_EXEC}"
DOWNLOAD_URL_SCHEDULIS_WEB="https://github.com/WeBankFinTech/Schedulis/releases/download/release-${SCHEDULIS_VERSION}/${TARFILENAME_SCHEDULIS_WEB}"
DOWNLOAD_URL_STREAMIS="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/Streamis/${STREAMIS_VERSION}/${TARFILENAME_STREAMIS}"
DOWNLOAD_URL_STREAMIS_WEB="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/Streamis/${STREAMIS_VERSION}/${TARFILENAME_STREAMIS_WEB}"
DOWNLOAD_URL_QUALITIS="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/Qualitis/${TARFILENAME_QUALITIS}"
DOWNLOAD_URL_DSS_WEB="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/DataSphereStudio/${DSS_VERSION}/${TARFILENAME_DSS_WEB}"
DOWNLOAD_URL_DSS="https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/DataSphereStudio/${DSS_VERSION}/${TARFILENAME_DSS}"
DOWNLOAD_URL_MYSQL_JDBC="https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/${TARFILENAME_MYSQL_JDBC}"
DOWNLOAD_URL_MYSQL="https://cdn.mysql.com/archives/mysql-5.7/${TARFILENAME_MYSQL}"

download ${DOWNLOAD_URL_SPARK} ${TARFILENAME_SPARK} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_FLINK} ${TARFILENAME_FLINK} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_SQOOP} ${TARFILENAME_SQOOP} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_VISUALIS} ${TARFILENAME_VISUALIS} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_EXCHANGIS} ${TARFILENAME_EXCHANGIS} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_EXCHANGIS_WEB} ${TARFILENAME_EXCHANGIS_WEB} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_SCHEDULIS_EXEC} ${TARFILENAME_SCHEDULIS_EXEC} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_SCHEDULIS_WEB} ${TARFILENAME_SCHEDULIS_WEB} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_QUALITIS} ${TARFILENAME_QUALITIS} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_STREAMIS} ${TARFILENAME_STREAMIS} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_STREAMIS_WEB} ${TARFILENAME_STREAMIS_WEB} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_DSS} ${TARFILENAME_DSS} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_DSS_WEB} ${TARFILENAME_DSS_WEB} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_MYSQL_JDBC} ${TARFILENAME_MYSQL_JDBC} ${WDS_TAR_DIR}
download ${DOWNLOAD_URL_MYSQL} ${TARFILENAME_MYSQL} ${WDS_TAR_DIR}