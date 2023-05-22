### for DSS-Server and Eventchecker APPCONN
MYSQL_HOST=wds
MYSQL_PORT=3306
MYSQL_DB=linkis
MYSQL_USER=linkis
MYSQL_PASSWORD=linkis

#主要是配合scriptis一起使用，如果不配置，会默认尝试通过$HIVE_CONF_DIR 中的配置文件获取
HIVE_META_URL=jdbc:mysql://cdhdev01.gzcb.com.cn:3306/metastore?useUnicode=true    # HiveMeta元数据库的URL
HIVE_META_USER=hive   # HiveMeta元数据库的用户
HIVE_META_PASSWORD=password    # HiveMeta元数据库的密码