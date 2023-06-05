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
3. 替换前端包。在目录/data/docker/Install/web/dss/linkis
4. 根据Apache Linkis的升级文档修改配置文件，配置文件目录在/data/docker/config/linkis-config
5. 启动服务
```shell
sh ${LINKIS_HOME}/sbin/linkis-start-all.sh
```
---

### Schedulis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
cd /data/docker/Install/schedulis/schedulis-exec/
bin/shutdown-exec.sh
cd /data/docker/Install/schedulis/schedulis-web/
bin/shutdown-web.sh
isSuccess "stop Schedulis"
```
2. 替换lib包。
首先需要备份jar包/data/docker/Install/schedulis/schedulis-exec/lib/derby.jar，再替换新版本的lib包在目录/data/docker/Install/schedulis/schedulis-exec/，后将备份的derby.jar拷贝到该目录lib下
3. 替换前端包。替换目录/data/docker/Install/schedulis/schedulis-web/，后将上一步备份的derby.jar拷贝到lib下
4. 修改配置文件。 根据Schedulis升级文档按需进行修改，配置文件目录在/data/docker/config/schedulis-config
5. 启动服务
```shell
cd /data/docker/Install/schedulis/schedulis-exec/
bin/start-exec.sh
cd /data/docker/Install/schedulis/schedulis-web/
bin/start-web.sh
```
---

### Visualis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh /data/docker/Install/visualis/visualis-server/bin/stop-visualis-server.sh
```
2. 替换lib包。直接用新的lib包替换/data/docker/Install/visualis/visualis-server/lib
3. 替换前端包。直接用新的前端包替换/data/docker/Install/web/dss/visualis
4. 修改配置文件。根据Visualis升级文档按需进行修改，配置文件目录在/data/docker/config/visualis
5. 启动服务
```shell
sh /data/docker/Install/visualis/visualis-server/bin/start-visualis-server.sh
```
---

### Qualitis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh /data/docker/Install/qualitis/qualitis_dev/bin/stop.sh
```
2. 替换lib包。直接用新的lib包替换/data/docker/Install/qualitis/qualitis-dev/lib
3. 替换前端包。直接用新的前端包替换/data/docker/config/qualitis/dev/static
4. 修改配置文件。根据Qualitis升级文档按需进行修改，配置文件目录在/data/docker/config/qualitis
5. 启动服务
```shell
sh /data/docker/Install/qualitis/qualitis_dev/bin/start.sh
```
---

### Exchangis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
cd /data/docker/Install/exchangis/background/sbin
./daemon.sh stop server
```
2. 替换lib包。直接用新的lib包替换/data/docker/Install/exchangis/background/lib
3. 替换前端包。直接用新的前端包替换/data/docker/Install/exchangis/frontend/dist
4. 修改配置文件。根据Exchangis升级文档按需进行修改，配置文件目录在/data/docker/config/exchangis-config
5. 启动服务
```shell
sh /data/docker/Install/exchangis/background/sbin/daemon.sh start server
```
---

### Streamis
在升级前请确保已适配DataSphereStudio v1.1.1，后可按照如下步骤进行升级
1. 停止服务
```shell
sh /data/docker/Install/streamis/streamis-server/bin/stop-streamis-server.sh
```
2. 替换lib包。直接用新的lib包替换/data/docker/Install/streamis/streamis-server/lib
3. 替换前端包。直接用新的前端包替换/data/docker/Install/streamis/frontend/dist
4. 修改配置文件。根据Streamis升级文档按需进行修改，配置文件目录在/data/docker/Install/streamis/streamis-server/conf
5. 启动服务
```shell
sh /data/docker/Install/streamis/streamis-server/bin/start-streamis-server.sh
```