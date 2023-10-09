## WeDataSphere组件容器化部署文档

> 为让使用CDH5.16.1版本的用户能够快速体验WeDataSphere所有组件，我们提供一个使用Docker构建的镜像包和Dockerfile文件，里面包括基础组件Spark、Flink、MySQL等。
>
> Hadoop、Hive、Yarn、HDFS等组件复用CDH5.16.1集群资源以及服务。
>
> WeDataSphere的组件有DSS、Linkis、Schedulis、Qualitis、Visualis、Exchangis。您只需要准备一台内存大小为32G，磁盘100G的机器，系统推荐使用CentOS或Red Hat，不推荐Ubuntu。按照如下步骤操作就能够在半小时内完成所有服务的部署与使用。

### 一、准备工作
1. 需要准备一台内存大小最少为32G，磁盘大小约为100G的服务器，部署前请确保该服务器上无其他服务在运行，以避免端口冲突

2. 将Docker安装在服务器
```shell
#1.下载docker依赖环境 
yum -y install yum-utils device-mapper-persistent-datalvm2

#2.设置docker镜像源 
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo   

#3.安装docker 
yum makecache fast yum install docker-ce docker-ce-cli containerd.io  

#4.启动docker服务 
systemctl start docker  

#5.测试服务是否正常启动   
docker run hello-world
```
*docker的安装因网络环境的差异，上述步骤可能无法完全适配，用户可根据实际网络环境安装docker并保证docker可用*

3. 安装CDH5.16.1客户端组件

   #1.将集群的hosts文件同步至新增客户端节点与其它节点
   #2.在新增客户端节点安装Kerberos客户端(可选)

   安装pam_krb5、sssd-krb5-common、sssd-krb5、krb5-workstation、krb5-libs等客户端包。

   将集群KDC服务器上的/etc/krb5.conf文件拷贝至客户端节点的/etc目录下。

   使用kinit命令测试Kerberos客户端能否成功使用。

   #3.将集群任意节点的/data/opt/cloudera/parcels目录压缩并拷贝到新增客户端节点

   tar -zcvf cdh.tar.gz /data/opt/cloudera/parcels

   解压到新增客户端的/data/opt/cloudera/parcels目录

   tar -xvf cdh.tar.gz

   #4.在新增客户端节点创建存放配置文件的目录

   mkdir -p /etc/hadoop

   mkdir -p /etc/hive

   #45将集群中拥有Gateway角色的节点将配置文件拷贝到新增客户端节点

   sudo scp -r /etc/hadoop/* xxxx:/etc/hadoop

   sudo scp -r /etc/hive/* xxxx:/etc/hive

4. 下载WeDataSphere容器化镜像包[点我下载](https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeDatasphere/DataSphereStudio/wedatasphere.tar.gz)

5. 上传镜像包到服务器

6. 编译镜像（可选）

   编译基础环境镜像：

   sudo docker build -f /data/package/WeDataSphere/wedatasphere-dist/base/base.Dockerfile -t base:0.0.1 /data/package/WeDataSphere/wedatasphere-dist/base

   编译应用镜像，需要提前下载好依赖的文件：

   sudo docker build -f /data/package/WeDataSphere/wedatasphere-dist/wds.Dockerfile -t wds:0.0.1 /data/package/WeDataSphere/wedatasphere-dist

### 二、部署步骤
1. 查看是否存在名称为wedatasphere的镜像，存在的话建议修改已有镜像的名称
```shell
docker images
```

2. 在服务器上加载镜像包(预计需要五分钟左右)和查看是否加载成功
```shell
#加载镜像包 
docker load -i wds.tar.gz 
#查看是否存在REPOSITORY名称为wedatasphere的镜像 
docker images
```

3. 将镜像运行在容器中 （请确保没有相同名称的container在运行）
```shell
sudo docker run --name wds --privileged=true -p 20921:20921 -p 1004:1004 -p 4040-4050:4040-4050 -p 3306:3306 -p 6121-6140:6121-6140 -p 8080:8080 -p 8020:8020 -p 8022:8022 -p 8032:8032 -p 8088:8088 -p 8085:8085 -p 8090:8090 -p 8098:8098 -p 9088:9088 -p 20303:20303 -p 10000-10009:10000-10009 -p 20000-20009:20000-20009 -p 30000-30009:30000-30009 -p 50020:50020 -v=/data/opt/cloudera:/data/opt/cloudera -v=/etc/hive/conf/hive-site.xml:/wedatasphere/install/spark-2.4.3-bin-hadoop2.6/conf/hive-site.xml -v=/etc/hadoop:/etc/hadoop -v=/etc/hive/conf:/etc/hive/conf -v=/home/hadoop/github/utopianet/WeDataSphere/wedatasphere-dist/mysql-data:/wedatasphere/install/mysql-5.7.36-el7-x86_64/data --add-host='wds07:172.16.16.16' --add-host='wds10:172.16.16.13' --add-host='wds12:172.16.16.12' -h wds -it wds:0.0.1

参数说明
/data/opt/cloudera该目录为CDH客户端目录。
/etc/hive/conf/hive-site.xml该文件是CDH Hive配置文件。
/etc/hive/conf/该目录是CDH Hive配置文件目录。
/etc/krb5.conf该文件为kerberos认证配置文件。(可选)
/home/hadoop/hadoop.keytab该文件为hadoop用户的kerberos认证的票据凭证。(可选)
/etc/hadoop 该目录是CDH hadoop配置文件目录。
/home/hadoop/github/utopianet/WeDataSphere/wedatasphere-dist/mysql-data该目录为mysql数据库的数据文件，存储了linkis、dss等数据库的数据文件，可以从网盘下载。
add-host 该参数控制容器中hosts文件的内容，需要将CDH集群中的所有节点的机器名以及对应的IP依次添加。
```

4. 进入容器
```shell
docker exec -it wds /bin/bash
```

5. 在容器中执行启动命令，并且输入宿主机IP
```shell
sh /wedatasphere/sbin/start-all.sh
```

6. 无报错的情况下就可以去登录DSS并使用
7. 在页面登录的ip为所在服务器的ip，端口为8089，用户名和密码均为hadoop/hadoop

8. 停止服务可执行stop_all.sh脚本
```shell
sh /wedatasphere/sbin/stop-all.sh
如发现不能完全停止，可以使用以下命令：
for pid in $(jps -v); do kill -9 $pid; done
```
