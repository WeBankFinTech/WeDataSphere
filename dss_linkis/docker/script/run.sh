echo "启动mysql"
/etc/init.d/mysqld start --user=mysql &
sleep 3
echo "启动nginx"
/usr/sbin/nginx -c /etc/nginx/nginx.conf
echo "配置hdfs路径"
source /etc/profile
sh /wedatasphere/cdh/bin/hdfs dfs -mkdir -p /tmp/test/linkis
sh /wedatasphere/cdh/bin/hdfs dfs -chmod 775 /tmp/test/linkis
echo "初始化配置文件"
python3 /wedatasphere/docker/script/db_update.py 
python3 /wedatasphere/docker/script/update_config.py 
/usr/sbin/nginx -s reload
echo "启动服务"
su - hdfs -s /bin/bash /wedatasphere/sbin/start-all.sh
