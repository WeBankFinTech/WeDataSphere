#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

######################################################################
# hadoop all in one image
######################################################################

ARG IMAGE_BASE=base:0.0.1

FROM ${IMAGE_BASE} as wds

ARG HADOOP_VERSION=2.6.0-cdh5.16.1
ARG HIVE_VERSION=1.1.0-cdh5.16.1
ARG SPARK_VERSION=2.4.3
ARG SPARK_HADOOP_VERSION=2.6
ARG FLINK_VERSION=1.12.2
ARG SQOOP_VERSION=1.4.6
ARG VISUALIS_VERSION=1.0.0
ARG EXCHANGIS_VERSION=1.1.1
ARG SCHEDULIS_VERSION=0.7.1
ARG STREAMIS_VERSION=0.2.0
ARG QUALITIS_VERSION=0.9.2
ARG DSS_VERSION=1.1.1
ARG LINKIS_VERSION=1.3.1
ARG LINKIS_SYSTEM_USER="hadoop"
ARG LINKIS_SYSTEM_UID="1002"
ARG LINKIS_SYSTEM_GROUP="hadoop"
ARG LINKIS_SYSTEM_GID="1002"
ARG LINKIS_HOME=/wedatasphere/install/linkis
ARG LINKIS_PLUGINS_PATH=${LINKIS_HOME}/lib/linkis-engineconn-plugins
ARG DSS_HOME=/wedatasphere/install/dss
ARG DSS_WEB_ROOT=/wedatasphere/install/web
ARG LINKIS_WEB_ROOT=/wedatasphere/install/web/dss/linkis
ARG LINKIS_CONF_DIR=${LINKIS_HOME}/conf
ARG LINKIS_LOG_DIR=${LINKIS_HOME}/logs
ARG WORKSPACE_USER_ROOT_PATH=/wedatasphere/workspace
ARG HDFS_USER_ROOT_PATH=/tmp/linkis4
ARG ENGINECONN_ROOT_PATH=/wedatasphere/logs

RUN mkdir -p /wedatasphere/sbin \
    && mkdir -p ${DSS_WEB_ROOT}/dss/linkis \
    && mkdir -p ${DSS_WEB_ROOT}/dss/streamis \
    && mkdir -p ${DSS_WEB_ROOT}/dss/exchangis/web \
    && mkdir -p /wedatasphere/install/schedulis/db \
    && mkdir -p ${LINKIS_HOME} \
    && mkdir -p ${LINKIS_LOG_DIR} \
    && mkdir -p ${LINKIS_CONF_DIR} \
    && mkdir -p /wedatasphere/install/dss \
    && mkdir -p /wedatasphere/config \
    && mkdir -p /wedatasphere/logs/schedulis \
    && mkdir -p /wedatasphere/logs/exchangis/main/logs \
    && mkdir -p /wedatasphere/logs/visualis-server \
    && mkdir -p /wedatasphere/logs/dss \
    && mkdir -p /wedatasphere/logs/qualitis \
    && mkdir -p /wedatasphere/logs/streamis \
    && mkdir -p /wedatasphere/auth \
    && mkdir -p /wedatasphere/tmp/visualis \
    && mkdir -p /wedatasphere/tmp/schedulis \
    && mkdir -p /wedatasphere/tmp/qualitis \
    && mkdir -p /wedatasphere/tmp/streamis \
    && mkdir -p /wedatasphere/tmp/exchangis \
    && mkdir -p /usr/share/fonts/visualis \
    && mkdir -p /opt/cloudera \
    && mkdir -p /wedatasphere/logs/mysql \
    && mkdir -p /var/lib/mysql \
    $$ mkdir -p ${WORKSPACE_USER_ROOT_PATH}/${LINKIS_SYSTEM_USER} \
    && mkdir -p ${ENGINECONN_ROOT_PATH}/${LINKIS_SYSTEM_USER} \
    && mkdir -p /wedatasphere/scripts/

ENV JAVA_HOME /usr/java/jdk1.8.0_181-cloudera
ENV SPARK_HOME /wedatasphere/install/spark-2.4.3-bin-hadoop2.6
ENV SPARK_CONF_DIR /wedatasphere/install/spark-2.4.3-bin-hadoop2.6/conf
ENV HIVE_HOME /data/opt/cloudera/parcels/CDH/lib/hive
ENV HIVE_CONF_DIR /etc/hive/conf
ENV hadoopVersion 2.6.0-cdh5.16.1
ENV YARN_RESTFUL_URL http://cdhdev02.gzcb.com.cn:8088
ENV HADOOP_HOME /data/opt/cloudera/parcels/CDH/lib/hadoop
ENV HADOOP_CONF_DIR /etc/hadoop/conf
ENV SQOOP_HOME /wedatasphere/install/sqoop-1.4.6.bin__hadoop-2.0.4-alpha
ENV SQOOP_CONF_DIR /wedatasphere/install/sqoop-1.4.6.bin__hadoop-2.0.4-alpha/conf
ENV FLINK_HOME /wedatasphere/install/flink-1.12.2
ENV VISUALIS_HOME /wedatasphere/install/visualis-server
ENV FLINK_CONF_DIR ${FLINK_HOME}/conf
ENV FLINK_LIB_DIR ${FLINK_HOME}/lib
ENV PYTHON_HOME /usr
ENV PYSPARK_ALLOW_INSECURE_GATEWAY 1
ENV ENABLE_METADATA_QUERY true
ENV LINKIS_CONF_DIR ${LINKIS_CONF_DIR}
ENV LINKIS_CLIENT_CONF_DIR ${LINKIS_CONF_DIR}/linkis-cli
ENV LINKIS_HOME ${LINKIS_HOME}
ENV EXCHANGIS_HOME /wedatasphere/install/exchangis
ENV STREAMIS_INSTALL_HOME /wedatasphere/install/streamis
ENV CDH_HOME /data/opt/cloudera/parcels/CDH
ENV MYSQL_HOME /wedatasphere/install/mysql-5.7.36-el7-x86_64
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_DB linkis
ENV MYSQL_USER linkis
ENV MYSQL_PASSWORD linkis
ENV PATH ${SQOOP_HOME}/bin:${JAVA_HOME}/bin:$PATH:${CDH_HOME}/bin:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${FLINK_HOME}/bin:${MYSQL_HOME}/bin

ADD target/wds-tars/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_VERSION}.tgz /wedatasphere/install
COPY spark-config/spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf
ADD target/wds-tars/flink-${FLINK_VERSION}-bin-scala_2.11.tgz /wedatasphere/install
ADD target/wds-tars/lib.tar.gz /wedatasphere/install/flink-${FLINK_VERSION}
ADD target/wds-tars/sqoop-${SQOOP_VERSION}.bin__hadoop-2.0.4-alpha.tar.gz /wedatasphere/install
COPY sqoop-config/sqoop-env.sh ${SQOOP_HOME}/conf/sqoop-env.sh
ADD target/wds-tars/jdk1.8.0_181-cloudera.tar.gz /
#ADD target/wds-tars/cdh.tar.gz /opt
ADD target/wds-tars/mysql-5.7.36-el7-x86_64.tar.gz /wedatasphere/install
COPY target/wds-tars/visualis_${VISUALIS_VERSION}_install_package.zip /wedatasphere/tmp/visualis
ADD target/wds-tars/wedatasphere-exchangis-${EXCHANGIS_VERSION}.tar.gz /wedatasphere/install/exchangis
#COPY target/wds-tars/dist.zip /wedatasphere/tmp/exchangis
ADD target/wds-tars/dist.tar.gz ${DSS_WEB_ROOT}/dss/exchangis/web
COPY target/wds-tars/exchangis-appconn.zip /wedatasphere/tmp/exchangis
COPY target/wds-tars/datax_engine.zip /wedatasphere/tmp/exchangis
COPY target/wds-tars/schedulis_${SCHEDULIS_VERSION}_exec.zip /wedatasphere/tmp/schedulis
COPY target/wds-tars/schedulis_${SCHEDULIS_VERSION}_web.zip /wedatasphere/tmp/schedulis
ADD target/wds-tars/wedatasphere-streamis-${STREAMIS_VERSION}-dist.tar.gz /wedatasphere/install/streamis
COPY target/wds-tars/streamis-${STREAMIS_VERSION}-dist.zip /wedatasphere/tmp/streamis
COPY target/wds-tars/streamis.zip /wedatasphere/tmp/streamis
ADD target/wds-tars/wedatasphere-dss-${DSS_VERSION}-dist.tar.gz /wedatasphere/tmp/dss
COPY target/wds-tars/wedatasphere-dss-web-${DSS_VERSION}-dist.zip /wedatasphere/tmp/dss
COPY target/wds-tars/qualitis-${QUALITIS_VERSION}.zip /wedatasphere/tmp/qualitis
COPY target/wds-tars/qualitis.zip /wedatasphere/tmp/qualitis
ADD target/wds-tars/apache-linkis-${LINKIS_VERSION}-bin.tar.gz /wedatasphere/tmp/linkis
ADD target/wds-tars/apache-linkis-${LINKIS_VERSION}-web-bin.tar.gz /wedatasphere/tmp/linkis
COPY target/wds-tars/hadoop-mapreduce-client-common-2.6.0-cdh5.16.1.jar /wedatasphere/tmp/linkis
COPY target/wds-tars/presto.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/trino.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/sqoop.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/flink.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/elasticsearch.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/io_file.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/jdbc.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/openlookeng.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/pipeline.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/seatunnel.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/datax.zip /wedatasphere/tmp/linkis
COPY target/wds-tars/dss_appconn_instance.sql ${LINKIS_HOME}
COPY mysql-config/my.cnf /etc/my.cnf
COPY sbin/*.sh /wedatasphere/sbin/
COPY scripts/*.sh /wedatasphere/scripts/
COPY target/wds-tars/execute-as-user /wedatasphere/tmp/schedulis
COPY schedulis-config /wedatasphere/config/schedulis-config
COPY target/wds-tars/phantomjs /wedatasphere/tmp/visualis
COPY target/wds-tars/hdp_schedulis_deploy_script.sql /wedatasphere/install/schedulis/db
COPY target/wds-tars/ddl.sql /wedatasphere/tmp/visualis
COPY target/wds-tars/davinci.sql /wedatasphere/tmp/visualis

    #ln -sf /data/opt/cloudera/parcels/CDH-5.16.1-1.cdh5.16.1.p0.3 /data/opt/cloudera/parcels/CDH \
    #&& ln -sf /data/opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35 /data/opt/cloudera/parcels/KAFKA \
    #&& ln -sf /data/opt/cloudera/parcels/SPARK2-2.3.0.cloudera4-1.cdh5.13.3.p0.611179 /data/opt/cloudera/parcels/SPARK2 \
RUN mv /wedatasphere/tmp/dss/dss-${DSS_VERSION}/* ${DSS_HOME}/ \
    && mv /wedatasphere/tmp/dss/db ${DSS_HOME}/db \
    && mv /wedatasphere/tmp/dss/bin ${DSS_HOME}/bin \
    && unzip -d ${DSS_WEB_ROOT} -o /wedatasphere/tmp/dss/wedatasphere-dss-web-${DSS_VERSION}-dist.zip \
    && mv /wedatasphere/tmp/linkis/linkis-package/* ${LINKIS_HOME}/ \
    && mv /wedatasphere/tmp/linkis/LICENSE  ${LINKIS_HOME}/ \
    && mv /wedatasphere/tmp/linkis/NOTICE   ${LINKIS_HOME}/ \
    && mv /wedatasphere/tmp/linkis/README.md  ${LINKIS_HOME}/ \
    && mv /wedatasphere/tmp/linkis/README_CN.md  ${LINKIS_HOME}/ \
    && mv /wedatasphere/tmp/linkis/dist/* ${LINKIS_WEB_ROOT} \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o ${DSS_HOME}/dss-appconns/linkis-engineplugin-appconn.zip \
    && mv ${LINKIS_PLUGINS_PATH}/linkis-engineplugin-appconn ${LINKIS_PLUGINS_PATH}/appconn \
    && sed -i 's/127.0.0.1/wds/g' ${LINKIS_PLUGINS_PATH}/appconn/dist/v1/conf/linkis-engineconn.properties \
    && sed -i 's/wds.linkis.server.mybatis.datasource.username=/wds.linkis.server.mybatis.datasource.username=linkis/g' ${LINKIS_PLUGINS_PATH}/appconn/dist/v1/conf/linkis-engineconn.properties \
    && sed -i 's/wds.linkis.server.mybatis.datasource.password=/wds.linkis.server.mybatis.datasource.password=linkis/g' ${LINKIS_PLUGINS_PATH}/appconn/dist/v1/conf/linkis-engineconn.properties \
    && unzip -d /wedatasphere/tmp/visualis -o /wedatasphere/tmp/visualis/visualis_${VISUALIS_VERSION}_install_package.zip \
    && unzip -d /wedatasphere/install -o /wedatasphere/tmp/visualis/visualis-server.zip \
    && unzip -d ${DSS_WEB_ROOT}/dss -o /wedatasphere/tmp/visualis/build.zip \
    && mv ${DSS_WEB_ROOT}/dss/build ${DSS_WEB_ROOT}/dss/visualis \
    && mv /wedatasphere/tmp/visualis/phantomjs /wedatasphere/install/visualis-server/bin \
    && unzip -d ${DSS_HOME}/dss-appconns -o /wedatasphere/tmp/visualis/visualis.zip \
    && unzip -d ${DSS_HOME}/dss-appconns -o /wedatasphere/tmp/qualitis/qualitis.zip \
    && unzip -d ${DSS_HOME}/dss-appconns -o /wedatasphere/tmp/exchangis/exchangis-appconn.zip \
    && unzip -d ${DSS_HOME}/dss-appconns -o /wedatasphere/tmp/streamis/streamis.zip \
    && cp /wedatasphere/tmp/visualis/ext/pf.ttf /usr/share/fonts/visualis \
    && fc-cache –fv \
    && unzip -d /wedatasphere/install/schedulis -o /wedatasphere/tmp/schedulis/schedulis_${SCHEDULIS_VERSION}_exec.zip \
    && unzip -d /wedatasphere/install/schedulis -o /wedatasphere/tmp/schedulis/schedulis_${SCHEDULIS_VERSION}_web.zip \
    && mv /wedatasphere/tmp/schedulis/execute-as-user /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_exec/lib \
    && chown root /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_exec/lib/execute-as-user \
    && chmod 6050 /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_exec/lib/execute-as-user \
    && unzip -d /wedatasphere/install -o /wedatasphere/tmp/qualitis/qualitis-${QUALITIS_VERSION}.zip \
    && unzip -d /wedatasphere/install/streamis -o /wedatasphere/install/streamis/share/streamis-server/streamis-server.zip \
    && unzip -d ${DSS_WEB_ROOT}/dss/streamis -o /wedatasphere/tmp/streamis/streamis-${STREAMIS_VERSION}-dist.zip \
    && tar -zxf  /wedatasphere/install/exchangis/packages/exchangis-server_${EXCHANGIS_VERSION}.tar.gz -C /wedatasphere/install/exchangis \
    && mkdir -p /wedatasphere/install/exchangis/engine/datax \
    && unzip -d /wedatasphere/install/exchangis/engine/datax -o /wedatasphere/tmp/exchangis/datax_engine.zip \
    && cp /wedatasphere/tmp/linkis/hadoop-mapreduce-client-common-2.6.0-cdh5.16.1.jar /wedatasphere/install/exchangis/engine/datax/plugin/reader/hdfsreader/libs/ \
    && cp /wedatasphere/tmp/linkis/hadoop-mapreduce-client-common-2.6.0-cdh5.16.1.jar /wedatasphere/install/exchangis/engine/datax/plugin/writer/hdfswriter/libs/ \
    #&& unzip -d ${DSS_WEB_ROOT}/dss/exchangis/web -o /wedatasphere/tmp/exchangis/dist.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/presto.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/trino.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/sqoop.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/flink.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/elasticsearch.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/io_file.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/jdbc.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/openlookeng.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/pipeline.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/seatunnel.zip \
    && unzip -d ${LINKIS_PLUGINS_PATH} -o /wedatasphere/tmp/linkis/datax.zip \
    && cp /wedatasphere/tmp/linkis/hadoop-mapreduce-client-common-2.6.0-cdh5.16.1.jar ${LINKIS_HOME}/lib/linkis-public-enhancements/linkis-ps-publicservice/metadataquery-service/hive \
    && mv ${LINKIS_PLUGINS_PATH}/hive/plugin/1.1.0-cdh5.16.1 ${LINKIS_PLUGINS_PATH}/hive/plugin/1.1.0_cdh5.16.1 \
    && mv ${LINKIS_PLUGINS_PATH}/hive/dist/v1.1.0-cdh5.16.1 ${LINKIS_PLUGINS_PATH}/hive/dist/v1.1.0_cdh5.16.1 \
    && sed -i 's/127.0.0.1/wds/g' ${LINKIS_HOME}/sbin/common.sh \
    && sed -i 's/return 1/return 0/g' ${LINKIS_HOME}/sbin/common.sh \
    && sed -i 's/hive-2.3.3/hive-1.1.0_cdh5.16.1/g' ${LINKIS_HOME}/bin/linkis-cli-hive \
    && sed -i 's/hive-2.3.3/hive-1.1.0_cdh5.16.1/g' ${LINKIS_HOME}/db/linkis_dml.sql \
    && sed -i 's#@YARN_RESTFUL_URL#http://cdhdev02.gzcb.com.cn:8088#g' ${LINKIS_HOME}/db/linkis_dml.sql \
    && sed -i 's#@HADOOP_VERSION#2.6.0-cdh5.16.1#g' ${LINKIS_HOME}/db/linkis_dml.sql \
    && sed -i 's/presto-0.234/presto-0.255/g' ${LINKIS_HOME}/db/linkis_dml.sql \
    && sed -i 's#/appcom/Install/dss/dss-appconns/workflow#/wedatasphere/install/dss/dss-appconns/workflow#g' ${DSS_HOME}/db/dss_dml.sql \
    && sed -i "s#/appcom/config/schedulis-config/#/wedatasphere/config/schedulis-config/#g" `grep /appcom/config/schedulis-config/ -rl /wedatasphere/install/schedulis/` \
    && sed -i "s#/appcom/logs/azkaban/#/wedatasphere/logs/schedulis/#g" `grep /appcom/logs/azkaban/ -rl /wedatasphere/install/schedulis/` \
    && sed -i "s#/appcom/logs/dataworkcloud/Query/#/wedatasphere/logs/visualis-server/#g" `grep /appcom/logs/dataworkcloud/Query/ -rl /wedatasphere/install/visualis-server/` \
    && sed -i "s#/appcom/tmp/wds/scheduler#/wedatasphere/tmp/wds/scheduler#g" ${DSS_HOME}/dss-appconns/schedulis/appconn.properties \
    && chmod +x /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_exec/bin/*.sh \
    && chmod +x /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_exec/bin/internal/*.sh \
    && chmod +x /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_web/bin/*.sh \
    && chmod +x /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_web/bin/internal/*.sh \
    && chmod +x /wedatasphere/install/visualis-server/bin/* \
    && mkdir -p /wedatasphere/install/visualis-server/db \
    && cp /wedatasphere/tmp/visualis/*.sql /wedatasphere/install/visualis-server/db \
    && ln -sf /wedatasphere/install/schedulis/schedulis_${SCHEDULIS_VERSION}_exec /wedatasphere/install/schedulis/schedulis-exec \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-exec/azkaban.properties /wedatasphere/install/schedulis/schedulis-exec/conf/azkaban.properties \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-exec/common.properties /wedatasphere/install/schedulis/schedulis-exec/plugins/jobtypes/common.properties \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-exec/commonprivate.properties /wedatasphere/install/schedulis/schedulis-exec/plugins/jobtypes/commonprivate.properties \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-exec/plugin.properties /wedatasphere/install/schedulis/schedulis-exec/plugins/jobtypes/linkis/plugin.properties \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-exec/private.properties /wedatasphere/install/schedulis/schedulis-exec/plugins/jobtypes/linkis/private.properties \
    && ln -sf /wedatasphere/install/schedulis/schedulis_0.7.1_web /wedatasphere/install/schedulis/schedulis-web \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-web/azkaban.properties /wedatasphere/install/schedulis/schedulis-web/conf/azkaban.properties \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-web/web_plugin_ims.properties /wedatasphere/install/schedulis/schedulis-web/plugins/alerter/WebankIMS/conf/plugin.properties \
    && ln -sf /wedatasphere/config/schedulis-config/schedulis-web/web_plugin_system.properties /wedatasphere/install/schedulis/schedulis-web/plugins/viewer/system/conf/plugin.properties \
    && rm -rf /wedatasphere/tmp/* \
    && mkdir -p /wedatasphere/tmp/uploads \
    && mkdir -p /wedatasphere/tmp/keytab \
    && mkdir -p /wedatasphere/tmp/wds/scheduler \
    && mkdir -p /wedatasphere/tmp/linkis/${LINKIS_SYSTEM_USER} \
    && chown -R ${LINKIS_SYSTEM_USER}:${LINKIS_SYSTEM_GROUP} /wedatasphere \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/schedulis/schedulis_0.7.1_exec/lib/linkis-label-common-1.1.1.jar \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/linkis/lib/linkis-label-common-1.1.1.jar \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/schedulis/schedulis_0.7.1_web/lib/linkis-label-common-1.1.1.jar \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/exchangis/lib/exchangis-server/linkis-label-common-1.1.1.jar \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/qualitis-0.9.2/lib/linkis-label-common-1.1.1.jar \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/streamis/share/streamis-server/streamis-server.zip \
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/streamis/streamis-server/lib/linkis-label-common-1.0.3.jar \    
    && cp ${LINKIS_HOME}/lib/linkis-computation-governance/linkis-cg-engineconnmanager/linkis-label-common-1.3.1.jar /wedatasphere/install/visualis-server/lib/linkis-label-common-1.1.1.jar \
    && sed -i "s#\[your_mysql_ip\]:\[your_mysql_port\]/\[your_db_name\]#wds:3306/qualitis#g" /wedatasphere/install/qualitis-0.9.2/conf/application-dev.yml \
    && sed -i "s#\[your_name\]#qualitis#g" /wedatasphere/install/qualitis-0.9.2/conf/application-dev.yml \
    && sed -i "s#\[your_pwd\]#qualitis#g" /wedatasphere/install/qualitis-0.9.2/conf/application-dev.yml \
    #&& sed -i "s#127.0.0.1#186.137.170.60#g" /wedatasphere/install/qualitis-0.9.2/conf/application-dev.yml \
    && sed -i "s#/appcom/logs/qualitis/logs/qualitis/#/wedatasphere/logs/qualitis/#g" /wedatasphere/install/qualitis-0.9.2/conf/log4j2-dev.xml \
    && sed -i "s#/appcom/logs/qualitis/#/wedatasphere/logs/qualitis/#g" /wedatasphere/install/qualitis-0.9.2/conf/log4j2-dev.xml \
    && sed -i "s#{IP}:{PORT}#wds:20303#g" /wedatasphere/install/exchangis/config/application-exchangis.yml \
    && sed -i "s#{LINKIS_IP}:{LINKIS_PORT}#wds:9001#g" /wedatasphere/install/exchangis/config/exchangis-server.properties \
    && sed -i "s#{IP}:{PORT}/{database}#wds:3306/exchangis#g" /wedatasphere/install/exchangis/config/exchangis-server.properties \
    && sed -i "s#{username}#exchangis#g" /wedatasphere/install/exchangis/config/exchangis-server.properties \
    && sed -i "s#{password}#exchangis#g" /wedatasphere/install/exchangis/config/exchangis-server.properties \
    && sed -i "s#MYSQL_HOST={IP}#MYSQL_HOST=wds#g" /wedatasphere/install/exchangis/config/db.sh \
    && sed -i "s#MYSQL_PORT={PORT}#MYSQL_PORT=3306#g" /wedatasphere/install/exchangis/config/db.sh \
    && sed -i "s#DATABASE={dbName}#DATABASE=exchangis#g" /wedatasphere/install/exchangis/config/db.sh \
    && sed -i "s#MYSQL_USERNAME={username}#MYSQL_USERNAME=exchangis#g" /wedatasphere/install/exchangis/config/db.sh \
    && sed -i "s#MYSQL_PASSWORD={password}#MYSQL_PASSWORD=exchangis#g" /wedatasphere/install/exchangis/config/db.sh \
    && sed -i "s#LINKIS_GATEWAY_HOST={IP}#LINKIS_GATEWAY_HOST=wds#g" /wedatasphere/install/exchangis/config/config.sh \
    && sed -i "s#LINKIS_GATEWAY_PORT={PORT}#LINKIS_GATEWAY_PORT=9001#g" /wedatasphere/install/exchangis/config/config.sh \
    && sed -i "s#EXCHANGIS_PORT={PORT}#EXCHANGIS_PORT=9321#g" /wedatasphere/install/exchangis/config/config.sh \
    && sed -i "s#EUREKA_URL=http://{IP:PORT}/eureka/#EUREKA_URL=http://wds:9001/eureka/#g" /wedatasphere/install/exchangis/config/config.sh \
    && echo "wds.exchangis.job.log.local.path=/wedatasphere/logs/exchangis/main/logs" >> /wedatasphere/install/exchangis/config/exchangis-server.properties \
    && sed -i "s#exchangis-server#exchangis-#g" /wedatasphere/install/exchangis/sbin/env.properties \
    && sed -i "s#/appcom/config/exchangis-config#/wedatasphere/install/exchangis/config#g" /wedatasphere/install/exchangis/sbin/env.properties \
    && sed -i "s#/appcom/logs/exchangis-log#/wedatasphere/logs/exchangis#g" /wedatasphere/install/exchangis/sbin/env.properties \
    && dos2unix /wedatasphere/install/qualitis-0.9.2/bin/* \
    && sed -i "s#127.0.0.1#wds#g" /wedatasphere/install/streamis/conf/config.sh \
    && sed -i "s#/appcom/Install/streamis#/wedatasphere/install/streamis#g" /wedatasphere/install/streamis/conf/config.sh \
    && sed -i "s#MYSQL_HOST=#MYSQL_HOST=wds#g" /wedatasphere/install/streamis/conf/db.sh \
    && sed -i "s#MYSQL_PORT=#MYSQL_PORT=3306#g" /wedatasphere/install/streamis/conf/db.sh \
    && sed -i "s#MYSQL_DB=#MYSQL_DB=streamis#g" /wedatasphere/install/streamis/conf/db.sh \
    && sed -i "s#MYSQL_USER=#MYSQL_USER=streamis#g" /wedatasphere/install/streamis/conf/db.sh \
    && sed -i "s#MYSQL_PASSWORD=#MYSQL_PASSWORD=streamis#g" /wedatasphere/install/streamis/conf/db.sh \
    && sed -i "s#sudo yum -y install dos2unix##g" /wedatasphere/install/streamis/bin/start.sh \
    && sed -i "s#port: 9321#port: 9421#g" /wedatasphere/install/streamis/streamis-server/conf/application.yml \
    && sed -i "s#http://127.0.0.1:20303/eureka/#http://wds:20303/eureka/#g" /wedatasphere/install/streamis/streamis-server/conf/application.yml \
    && sed -i "s#localhost#wds#g" /wedatasphere/install/streamis/streamis-server/conf/linkis.properties \
    && sed -i "s#wds.linkis.server.mybatis.datasource.username=user1#wds.linkis.server.mybatis.datasource.username=streamis#g" /wedatasphere/install/streamis/streamis-server/conf/linkis.properties \
    && sed -i "s#wds.linkis.server.mybatis.datasource.password=pwd1#wds.linkis.server.mybatis.datasource.password=streamis#g" /wedatasphere/install/streamis/streamis-server/conf/linkis.properties \
    && sed -i "s#wds.linkis.gateway.ip=#wds.linkis.gateway.ip=wds#g" /wedatasphere/install/streamis/streamis-server/conf/linkis.properties \
    && sed -i "s#wds.linkis.gateway.port=#wds.linkis.gateway.port=9001#g" /wedatasphere/install/streamis/streamis-server/conf/linkis.properties \
    && sed -i "s#logs/#/wedatasphere/logs/streamis/#g" /wedatasphere/install/streamis/streamis-server/conf/log4j2.xml \
    && find /wedatasphere/install -name jasper-compiler-5.5.23.jar -type f -print -delete \
    && find /wedatasphere/install -name jasper-runtime-5.5.23.jar -type f -print -delete \
    && find /wedatasphere/install/linkis/lib/linkis-engineconn-plugins/datax -name logback-core-1.2.3.jar -type f -print -delete \
    && find /wedatasphere/install/linkis/lib/linkis-engineconn-plugins/datax -name logback-classic-1.2.3.jar -type f -print -delete \
    && mkdir -p ${MYSQL_HOME}/data \
    && cp ${MYSQL_HOME}/support-files/mysql.server /etc/init.d/mysql \
    && cp  /wedatasphere/install/qualitis-0.9.2/lib/mysql-connector-java-5.1.49.jar /wedatasphere/install/visualis-server/lib/ \
    && cp  /wedatasphere/install/qualitis-0.9.2/lib/mysql-connector-java-5.1.49.jar /wedatasphere/install/spark-2.4.3-bin-hadoop2.6/jars/ \
    && cp  /wedatasphere/install/qualitis-0.9.2/lib/mysql-connector-java-5.1.49.jar /wedatasphere/install/sqoop-1.4.6.bin__hadoop-2.0.4-alpha/lib \
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/linkis/lib/linkis-engineconn-plugins/appconn/dist/v1/lib/ \
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/streamis/streamis-server/lib/ \
    && rm /wedatasphere/install/streamis/streamis-server/lib/mysql-connector-java-5.1.47.jar \
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/streamis/streamis-server/lib/ \
    && rm /wedatasphere/install/visualis-server/lib/mysql-connector-java-5.1.44.jar \
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/schedulis/schedulis_0.7.1_web/lib/ \
    && rm /wedatasphere/install/schedulis/schedulis_0.7.1_web/lib/mysql-connector-java-8.0.18.jar \
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/eventchecker/extlib/ \
    && rm /wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/eventchecker/extlib/mysql-connector-java-8.0.18.jar \
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/datachecker/extlib/ \
    && rm /wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/datachecker/extlib/mysql-connector-java-8.0.18.jar \    
    && cp /wedatasphere/install/dss/lib/dss-commons/mysql-connector-java-5.1.49.jar /wedatasphere/install/schedulis/schedulis_0.7.1_exec/lib/ \
    && rm /wedatasphere/install/schedulis/schedulis_0.7.1_exec/lib/mysql-connector-java-8.0.18.jar
COPY linkis-config ${LINKIS_HOME}/conf
COPY dss-config ${DSS_HOME}/conf
COPY nginx-config /etc/nginx/conf.d
COPY visualis-config ${VISUALIS_HOME}/conf
USER ${LINKIS_SYSTEM_USER}
COPY system-config/.bash_profile /home/hadoop/.bash_profile
RUN  ssh-keygen -t rsa -f /home/${LINKIS_SYSTEM_USER}/.ssh/id_rsa \
     && cp /home/${LINKIS_SYSTEM_USER}/.ssh/id_rsa.pub /home/${LINKIS_SYSTEM_USER}/.ssh/authorized_keys \
     && chmod +x /wedatasphere/sbin/*.sh
#ENTRYPOINT ["sh","/wedatasphere/sbin/start-all.sh"]
ENTRYPOINT ["/bin/bash"]