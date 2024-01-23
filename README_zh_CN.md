[English](README.md) | [中文](README_zh_CN.md)

## WeDataSphere 已开源组件

# *[DataSphere Studio](https://github.com/WeBankFinTech/DataSphereStudio)* 

**[点我](https://github.com/WeBankFinTech/DataSphereStudio)进入Github repo**

[DataSphere Studio](https://github.com/WeBankFinTech/DataSphereStudio)定位为数据应用开发门户，闭环涵盖数据应用开发全流程。在统一的UI下，以工作流式的图形化拖拽开发体验，满足从数据导入、脱敏清洗、分析挖掘、质量检测、可视化展现、定时调度到数据输出应用等，数据应用开发全流程场景需求。

# *[Qualitis](https://github.com/WeBankFinTech/Qualitis)* 

**[点我](https://github.com/WeBankFinTech/Qualitis)进入Github repo**

[Qualitis](https://github.com/WeBankFinTech/Qualitis)是一个支持多种异构数据源的质量校验、通知、管理服务的一站式数据质量管理平台，用于解决业务系统运行、数据中心建设及数据治理过程中的各种数据质量问题。

# *[Linkis](https://github.com/WeBankFinTech/Linkis)* 

**[点我](https://github.com/WeBankFinTech/Linkis)进入Github repo**

[Linkis](https://github.com/WeBankFinTech/Linkis)是一个打通了多个计算存储引擎如：Spark、Flink、Hive、Python和HBase等，对外提供统一REST/WS/JDBC接口，提交执行SQL、Pyspark、HiveQL、Scala等脚本的计算中间件。

# *[Scriptis](https://github.com/WeBankFinTech/Scriptis)*

**[点我](https://github.com/WeBankFinTech/Scriptis)进入GitHub repo**

[Scriptis](https://github.com/WeBankFinTech/Scriptis)是一款支持在线写SQL、Pyspark、HiveQL等脚本，提交给Linkis执行的交互式数据分析Web工具，且支持UDF、函数、资源管控和智能诊断等企业级特性。

<br>
更多开源组件，敬请期待...

----

## WeDataSphere 介绍

WeDataSphere是一套一站式、金融级、全连通、开源开放的大数据平台套件。基础平台由数据交换、数据分发、计算、存储四大层次组成，关注底层数据传输计算存储能力；功能平台由平台工具、数据工具、应用工具三大层次组成，关注用户各类功能工具需求实现。形成了完整的大数据平台技术体系，提供一站式的丰富数据平台组件及功能支撑。

----

## WeDataSphere 核心特点

- 基础能力<br>
基于开源社区的各种开源组件，如：Hadoop、Spark、Hbase、KubeFlow和FFDL等，构建金融级可靠基础计算存储数据交换能力，及强大的机器学习能力。并在开源版本基础上做加法，解决实际应用场景中遇到的安全、性能、高可用、可管理性等问题及各种bug修复。

- 平台工具<br>
提供平台门户、数据中间件Linkis和运营管理系统。平台门户支持产品地图、多租户管控、财务计费、接入方案智能推荐、运营报表和云服务申请；Linkis打造数据中间件，提供金融级多租户、资源管控、权限隔离等能力，连接上层应用和下层计算存储系统，主动填补开源社区和行业空白；运营管理系统涵盖集群管理、配置管理、变更管理、监控管理与服务请求自动化，支持一键安装、一键升级和图形化运维，并提供了预警、健康监测诊断、故障自愈等功能，简化平台的运维过程。

- 数据工具<br>
提供数据地图、数据脱敏工具、数据质量工具和跨Hadoop集群的数据传输工具。数据地图管理全行数据资源，包括元数据管理、数据权限、数据血缘，及开发中的数据质量、数据模型等功能模块。数据脱敏工具支持对高密级数据进行脱敏，避免用户直接接触高密级原始数据。数据质量工具提供一整套统一的流程来定义和检测数据集的质量并及时报告问题。跨Hadoop集群的数据传输工具支持数据传输任务调度、状态、统计、监控等管理工作。

- 应用工具<br>
提供开发探索工具Scriptis、图形化工作流调度系统、数据展现BI工具和机器学习支持系统。Scriptis支持对接多种计算存储引擎，并提供图形化、多编程语言支持。调度系统提供图形化界面做工作流定义和定时调度执行、依赖展示、状态查看、历史统计、监控配置等功能。BI工具支持通过图形化界面拖拽和简单脚本编写，生成各种图报表，同时支持邮件定时发送功能。机器学习支持系统提供多种模型训练调试方式，集成自研的机器学习算法和多种开源机器学习框架，具备异构高性能集群的多租户管理能力。

----

## WeDataSphere 核心优势

- 一站式<br>
 提供从数据应用开发到数据可视化、从批量作业到实时流式计算能力等的丰富功能组件，满足不同场景的数据应用开发运行和数据管理需求。

- 金融级<br>
  在高可用、数据治理、数据安全等方面做多种增强，打造金融级高可靠大数据平台，支撑核心关键业务应用。

- 全连通<br>
  独有数据应用开发管理门户DataSphere Studio 和计算中间件Linkis ，两层连通和集成的架构设计，使平台内各组件间南北东西向真正打通，提供更无缝的用户体验，更简化的平台架构，更强大的管控功能。

- 开源开放<br>
  WeDataSphere 基于开源，回到开源，自研的各种组件会逐步开源；整体设计上开放灵活，对扩展友好且组件可插拔；同时以开源开放的形式，吸引更多个人、组织，参与到WDS的开发建设和推广应用中来。

----

## WeDataSphere Community

如果您想得到最快的响应，请给我们提issue，或者您也可以扫码进群：
![weChatAndQQ](https://private-user-images.githubusercontent.com/11496700/298802263-bf309bad-27a7-481d-bc82-0df428f6d332.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MDU5ODMxNjgsIm5iZiI6MTcwNTk4Mjg2OCwicGF0aCI6Ii8xMTQ5NjcwMC8yOTg4MDIyNjMtYmYzMDliYWQtMjdhNy00ODFkLWJjODItMGRmNDI4ZjZkMzMyLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDAxMjMlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwMTIzVDA0MDc0OFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWZmOThiZDMyZTUyYzdmNGFlMzYzNmUzNTRhOWQ0MTdlZTcwMzEzYjg5YzMwZjUzMjFiZjk3YWJmMTk0MWFlMTQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.yI6wP-ssnMqlh2YlHFqigeHYNKRq8SoLKK8STsUeijo)
