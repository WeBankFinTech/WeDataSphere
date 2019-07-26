[English](README.md) | [中文](README_zh_CN.md)

## Introduction

WeDataSphere is a financial level one-stop open-source suitcase for big data platforms. The fundamental platform consists of 4 layers for data exchange, data distribution, computation and storage; The functional platform consists of 3 layers for platform tools, data tools and application tools, focusing on the implementations of various user requirements about functional tools. These construct as a complete technical ecosystem of big data platform and provides one-stop sufficient components and functionalities support. 

## Open Source Component

### [Linkis](https://github.com/WeBankFinTech/Linkis)
[Linkis](https://github.com/WeBankFinTech/Linkis) connects with compuation/storage engines(Spark, Flink, Hive, Python and HBase), exposes REST/WS interface, and executes multi-language jobs(SQL, Pyspark, HiveQL and Scala), as a data middleware.

### [Scriptis](https://github.com/WeBankFinTech/Scriptis)
[Scriptis](https://github.com/WeBankFinTech/Scriptis) is for interactive data analysis with script development(SQL, Pyspark, HiveQL), task submission(Spark, Hive), UDF, function, resource management and intelligent diagnosis.

<br>
More open source components, stay tuned...

## Core Features

- Fundamental capabilities

Powered by miscellaneous open-source components contributed by the community, such as Hadoop, Spark, Hbase, KubeFlow adn FFDL, WeDataSphere achieves financial level reliability on infrastructural data computation, storage and exchange. It also contributes some enhancements to those open-source versions by addressing security, performance, availability and manageability issues in practice with bug fixes. 

- Platform tools

Consists of a platform portal, a data middleware(Linkis) and an operation management system. The platform portal supports product map, financial expense calculation and cloud service application; As a data middleware, Linkis links concrete applications up with underlying computation/storage systems with capabilities of financial level multi-tenant, resource governance and access isolation, filling gaps for the open-source community and the industry; The operation management system encompasses cluster management, configuration management, change management and service request automation, supports one-click installation, one-click upgrade and graphical operation&maintenance, and provides functionalities of alert, health monitoring&diagnosis and automatic recovery, simplifying the operation&maintenance process of the platform.

- Data tools

Consists of data map, data desensitization, data quality and data exchange tools across different Hadoop clusters. Data map manages the universal data resource of the whole bank, with components of meta-data management, data access control, data consanguinity and the on-developing data quality and data model functions. Data desensitization desensitizes highly confidential data and keeps users from accessing it directly. The data quality tool provides a unique process to define and detect the quality of datasets with immediate problem reporting. The data exchange tools across different Hadoop clusters supports the scheduling, monitoring, statistics and management for data exchange tasks.

- Application tools

Consists of the development&exploration tool(Scriptis), a graphical workflow scheduling system, a data visualization BI tool and a machine learning support system. Scriptis connects with various computation/storage engines with graphical interface and multi development languages support. The graphical workflow scheduling system provides a graphical interface for workflow definition, job execution, dependency reveal, status display, historical statistics and monitoring configuration. The data visualization BI tool generates various charts by drag&drop operations and simple scripting, with scheduled email available. The machine learning support system supports multiple model training mode, including both self-developed ML algorithms and open-source ML frameworks, with multi-tenant management alility for high-performance clusters.

## Core Advantages 

- Sufficient application tools

  The 3 layers of platform tools, data tools and application tools plus the powerful machine learning capability, build up an enterprise big data solution.

- Synchronization across clusters among 3 datacenters in 2 cities

  Effecient&reliable big data transportation across clusters/IDCs, with sophisticated data backup and disaster tolerance solutions.

- Security
  
  Unified security control, fully container/microservice adoption and multi-tenant isolation for different layers.

- Links islets from multiple directions
  
  The unique data middleware(Linkis) links up systems in different layers, bringing data consanguinity, code reusability and user resources altogether.

## Community

If you desire immediate response, please kindly raise issues to us or scan the below QR code by WeChat and QQ to join our group:
<br>
![introduction05](images/introduction/introduction05.jpg)
