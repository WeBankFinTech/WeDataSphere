## Docker中组件升级指南

> 本文档主要用于如何对镜像中的WDS组件进行升级，升级前请确保组件版本适配

### DataSphereStudio
由于DataSphereStudio使用的已是最新版本v1.1.1，后续新版本发布后会提供相应升级文档

---
### Apache Linkis
在升级前请确保新的版本已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh ${LINKIS_HOME}/sbin/linkis-stop-all.sh
```
2. 替换后端lib包。用户首先需要将${LINKIS_HOME}/lib/linkis-engineconn-plugins中定制化的插件包备份，再用新版本的lib替换${LINKIS_HOME}/lib，最后将备份的插件包拷贝到${LINKIS_HOME}/lib/linkis-engineconn-plugins中
3. 替换前端包。在目录/wedatasphere/install/web/dss/linkis
4. 根据Apache Linkis的升级文档修改配置文件，配置文件目录在${LINKIS_HOME}/conf
5. 启动服务
```shell
sh ${LINKIS_HOME}/sbin/linkis-start-all.sh
```
---

### Schedulis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
cd /wedatasphere/install/schedulis/schedulis_0.7.1_exec/
bin/start-exec.sh
cd /wedatasphere/install/schedulis/schedulis_0.7.1_web/
bin/start-web.sh
isSuccess "start Schedulis"
```
2. 替换lib包

/wedatasphere/install/schedulis/schedulis_0.7.1_exec/lib/

/wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/linkis/lib

/wedatasphere/install/schedulis/schedulis_0.7.1_web/lib/

2. 替换前端包。替换目录/wedatasphere/install/schedulis/schedulis-web
3. 修改配置文件。 根据Schedulis升级文档按需进行修改，配置文件目录在/wedatasphere/config/schedulis-config
4. 启动服务

```shell
cd /wedatasphere/install/schedulis/schedulis_0.7.1_exec/
bin/start-exec.sh
cd /wedatasphere/install/schedulis/schedulis_0.7.1_web/
bin/start-web.sh
isSuccess "start Schedulis"
```
---

### Visualis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh /wedatasphere/install/visualis-server/bin/stop-visualis-server.sh
```
2. 替换lib包。直接用新的lib包替换/wedatasphere/install/visualis-server/lib
3. 替换前端包。直接用新的前端包替换/wedatasphere/install/web/dss/visualis
4. 修改配置文件。根据Visualis升级文档按需进行修改，配置文件目录在/wedatasphere/install/visualis-server/conf
5. 启动服务
```shell
sh /wedatasphere/install/visualis-server/bin/restart-visualis-server.sh
```
---

### Qualitis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh /wedatasphere/install/qualitis-0.9.2/bin/stop.sh
```
2. 替换lib包。直接用新的lib包替换/wedatasphere/install/qualitis-0.9.2/lib
3. 替换前端包。直接用新的前端包替换/wedatasphere/install/qualitis-0.9.2/conf/static
4. 修改配置文件。根据Qualitis升级文档按需进行修改，配置文件目录在/wedatasphere/install/qualitis-0.9.2/conf
5. 启动服务
```shell
sh /wedatasphere/install/qualitis-0.9.2/bin/start.sh
```
---

### Exchangis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
cd /wedatasphere/install/exchangis/sbin/
./daemon.sh stop server
```
2. 替换lib包。直接用新的lib包替换/wedatasphere/install/exchangis/lib
3. 替换前端包。直接用新的前端包替换/wedatasphere/install/web/dss/exchangis/web/dist
4. 修改配置文件。根据Exchangis升级文档按需进行修改，配置文件目录在/wedatasphere/install/exchangis/config/
5. 启动服务
```shell
sh  /wedatasphere/install/exchangis/sbin/daemon.sh start server
```
---

### Streamis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh /wedatasphere/install/streamis/streamis-server/bin/stop-streamis-server.sh
```
2. 替换lib包。直接用新的lib包替换/wedatasphere/install/streamis/streamis-server/lib
3. 替换前端包。直接用新的前端包替换/wedatasphere/install/web/dss/streamis/dist
4. 修改配置文件。根据Streamis升级文档按需进行修改，配置文件目录在/wedatasphere/install/streamis/streamis-server/conf
5. 启动服务
```shell
sh /wedatasphere/install/streamis/streamis-server/bin/start-streamis-server.sh
```