## Docker版本使用指南
> 本文档主要介绍在使用Docker镜像包启动WeDataSphere所有组件后该如何使用

**需要注意，由于镜像中部署的Hadoop, Spark等基础组件均是单节点的，稳定性必然不高，因此Docker版本无法用于生产**

1. 容器中各组件安装包均在/data/docker/Install目录下，除Streamis的配置文件在/data/docker/Install/streamis/streamis-server/conf目录，其他组件配置文件均在/data/docker/config目录下，日志均在/data/docker/logs目录，
---
2. Linkis和Visualis的前端包分别在目录/data/docker/Install/web/dss/linkis和/data/docker/Install/web/dss/visualis；DSS前端包在/data/docker/Install/web/dist；Schedulis前端包在/data/docker/Install/schedulis/schedulis-web/；Qualitis前端包在目录/data/docker/config/qualitis/dev/static；Exchangis前端包在目录/data/docker/Install/exchangis/frontend；Streamis前端包在/data/docker/Install/streamis/streamis-server/frontend
---
3. 镜像中提供了两个简单Demo项目TestDemoDocker和TestStreamis，用户登录后选择首页在默认工作空间bdapWorkspace下能够看到
---
4. 项目TestDemoDocker中有工作流TestDemo，该工作流主要包含DataSphereStudio中常用的节点，您可以选择执行并查看执行结果，并且可以将该工作流发布到调度中心，再从左侧菜单栏进入Schedulis调度中心，查看发布过去的工作流，对其进行调度
---
5. 项目TestStreamis是流式生产中心的Demo，您打开项目后需要在从开发中心切换到流式生产中心，启动作业名称为flink-cdc的作业。该作业的功能是读取数据库streamis_test中表streamis_source_table的binlog信息，写到表streamis_sink_table中
---
6. 除已有的两个项目外，您也可以选择自己创建项目和工作流，进行简单测试和演示，但是需要主要的是由于基础引擎对资源要求较高，若部署镜像的机器可用内存只有32G，执行复杂的任务会出现OOM异常