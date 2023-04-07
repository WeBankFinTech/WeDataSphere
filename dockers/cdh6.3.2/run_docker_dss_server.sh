# 启动容器
docker run  --name dss_linkis_server_v1 \
-h dss.node.cn \
-e HOST_IP=172.16.13.133 \
-v /opt/cloudera/parcels/CDH:/wedatasphere/cdh \
-v /opt/cloudera/parcels:/opt/cloudera/parcels \
-v /usr/local/service/spark3:/opt/service/spark3 \
-v /opt/cloudera/parcels/FLINK:/opt/service/flink \
-v /etc/hadoop/conf:/etc/hadoop/conf \
-v /etc/sqoop/conf:/etc/sqoop/conf \
-v /etc/hive/conf:/etc/hive/conf \
-p 3306:3306 \
-p 8085:8085 \
-p 9600:9600 \
-p 8060:8060 \
-p 8090:8090 \
-p 9098:9098 \
-p 8055:8055 \
-itd dss_linkis_server_test