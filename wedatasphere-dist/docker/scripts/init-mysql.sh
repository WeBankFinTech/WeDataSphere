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

MYSQL_HOME=/wedatasphere/install/mysql-5.7.36-el7-x86_64
LINKIS_HOME=/wedatasphere/install/linkis
DSS_HOME=/wedatasphere/install/dss
export PATH=$PATH:${MYSQL_HOME}/bin
rm -rf ${MYSQL_HOME}/data/*
mysqld --defaults-file=/etc/my.cnf --socket=/var/lib/mysql/mysql.sock --basedir=${MYSQL_HOME} --datadir=${MYSQL_HOME}/data/ --user=root --initialize-insecure
service mysql restart
sleep 15s
mysql -uroot -e "set PASSWORD = PASSWORD('root');"
mysql -uroot -proot -e "flush privileges;"
mysql -uroot -proot -e "use mysql;" 
mysql -uroot -proot -e "create user 'linkis'@'%' identified by 'linkis';"
mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS linkis DEFAULT CHARSET utf8 COLLATE utf8_general_ci;"
mysql -uroot -proot -e "use linkis;grant all privileges on linkis to 'linkis'@'%';"
mysql -uroot -proot -e "use linkis;grant all on linkis.* to linkis@'%';"
mysql -uroot -proot -e "flush privileges;"
mysql -ulinkis -plinkis -e "use linkis;"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${LINKIS_HOME}/db/linkis_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${LINKIS_HOME}/db/linkis_dml.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${DSS_HOME}/db/dss_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${DSS_HOME}/db/dss_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${DSS_HOME}/db/apps/dss_guide_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${DSS_HOME}/db/apps/dss_dataapi_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ulinkis -plinkis -Dlinkis  --default-character-set=utf8 -e "source ${DSS_HOME}/db/apps/dss_apiservice_ddl.sql"

mysql -uroot -proot -e "create user 'schedulis'@'%' identified by 'schedulis';"
mysql -uroot -proot -e "CREATE DATABASE schedulis DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -proot -e "use schedulis;grant all privileges on schedulis to 'schedulis'@'%';"
mysql -uroot -proot -e "use schedulis;grant all on schedulis.* to schedulis@'%';"
mysql -uroot -proot -e "flush privileges;"
mysql -uschedulis -pschedulis -e "use schedulis;"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -uschedulis -pschedulis -Dschedulis  --default-character-set=utf8 -e "source /wedatasphere/install/schedulis/db/hdp_schedulis_deploy_script.sql"

mysql -uroot -proot -e "create user 'visualis'@'%' identified by 'visualis';"
mysql -uroot -proot -e "CREATE DATABASE visualis DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -proot -e "use visualis;grant all privileges on visualis to 'visualis'@'%';"
mysql -uroot -proot -e "use visualis;grant all on visualis.* to visualis@'%';"
mysql -uroot -proot -e "flush privileges;"
mysql -uvisualis -pvisualis -e "use visualis;"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -uvisualis -pvisualis -Dvisualis  --default-character-set=utf8 -e "source /wedatasphere/install/visualis-server/logs/davinci.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -uvisualis -pvisualis -Dvisualis  --default-character-set=utf8 -e "source /wedatasphere/install/visualis-server/logs/ddl.sql"

mysql -uroot -proot -e "create user 'qualitis'@'%' identified by 'qualitis';"
mysql -uroot -proot -e "CREATE DATABASE qualitis DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -proot -e "use qualitis;grant all privileges on qualitis to 'qualitis'@'%';"
mysql -uroot -proot -e "use qualitis;grant all on qualitis.* to qualitis@'%';"
mysql -uroot -proot -e "flush privileges;"
mysql -uqualitis -pqualitis -e "use qualitis;"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -uqualitis -pqualitis -Dqualitis  --default-character-set=utf8 -e "source /wedatasphere/install/qualitis-0.9.2/conf/database/init.sql"

mysql -uroot -proot -e "create user 'exchangis'@'%' identified by 'exchangis';"
mysql -uroot -proot -e "CREATE DATABASE exchangis DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -proot -e "use exchangis;grant all privileges on exchangis to 'exchangis'@'%';"
mysql -uroot -proot -e "use exchangis;grant all on exchangis.* to exchangis@'%';"
mysql -uroot -proot -e "flush privileges;"
mysql -uexchangis -pexchangis -e "use exchangis;"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -uexchangis -pexchangis -Dexchangis  --default-character-set=utf8 -e "source /wedatasphere/install/exchangis/db/exchangis_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -uexchangis -pexchangis -Dexchangis  --default-character-set=utf8 -e "source /wedatasphere/install/exchangis/db/exchangis_dml.sql"

mysql -uroot -proot -e "create user 'streamis'@'%' identified by 'streamis';"
mysql -uroot -proot -e "CREATE DATABASE streamis DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -proot -e "use streamis;grant all privileges on streamis to 'streamis'@'%';"
mysql -uroot -proot -e "use streamis;grant all on streamis.* to streamis@'%';"
mysql -uroot -proot -e "flush privileges;"
mysql -ustreamis -pstreamis -e "use streamis;"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ustreamis -pstreamis -Dstreamis  --default-character-set=utf8 -e "source /wedatasphere/install/streamis/db/streamis_ddl.sql"
mysql --default-character-set=utf8 --socket=/var/lib/mysql/mysql.sock -ustreamis -pstreamis -Dstreamis  --default-character-set=utf8 -e "source /wedatasphere/install/streamis/db/streamis_dml.sql"