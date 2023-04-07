# !/usr/bin/python3
# -*- coding: utf-8 -*-
"""
@IDE     :   PyCharm
@File    :   update_config.py
@Time    :   2023-03-06 16:54
@Place   :   BeiJing
@Author  :   Zsy
@Version :   1.0
"""
import yaml
import configparser
import socket

file_list = [
    "/wedatasphere/install/dss_linkis/dss/conf/config.sh",
    "/wedatasphere/install/dss_linkis/dss/conf/application-dss.yml",
    "/wedatasphere/install/dss_linkis/dss/conf/dss.properties",
    "/wedatasphere/install/dss_linkis/dss/conf/dss-workflow-server.properties",
    "/wedatasphere/install/dss_linkis/linkis/conf/application-linkis.yml",
    "/wedatasphere/install/dss_linkis/linkis/conf/application-eureka.yml",
    "/wedatasphere/install/dss_linkis/linkis/conf/linkis-env.sh",
    "/wedatasphere/install/dss_linkis/linkis/sbin/common.sh",
    "/wedatasphere/install/dss_linkis/linkis/conf/linkis.properties",
    "/wedatasphere/install/dss_linkis/linkis/conf/linkis-ps-publicservice.properties",
    "/wedatasphere/install/dss_linkis/web/config.sh",
    "/wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/linkis/plugin.properties",
    "/wedatasphere/install/schedulis/schedulis_0.7.1_exec/plugins/jobtypes/linkis/bin/config.sh",
    "/wedatasphere/install/schedulis/schedulis_0.7.1_exec/conf/host.properties",
    "/etc/nginx/conf.d/dss.conf",
    "/etc/nginx/conf.d/exchangis.conf",
    "/etc/nginx/conf.d/streamis.conf"
]

sh_file_list, yml_file_list, pro_file_list = [], [], []


def file_types():
    for file_path in file_list:
        if file_path.endswith(".sh") or file_path.endswith(".conf"):
            sh_file_list.append(file_path)
        if file_path.endswith(".yml"):
            yml_file_list.append(file_path)
        if file_path.endswith(".properties"):
            pro_file_list.append(file_path)


def get_host_ip():
    # 获取计算机名称
    hostname = socket.gethostname()
    # 获取本机IP
    ip = socket.gethostbyname(hostname)
    # ip = os.getenv("HOST_IP")
    return ip


# 读文件
def file_read(read_path):
    # 打开文件
    file_data = open(read_path, encoding='utf8')
    file_read_data = file_data.read()
    # 关闭文件
    file_data.close()
    return file_read_data


# 写文件
def file_write(write_path, res):
    # 打开文件
    with open(write_path, 'w', encoding='utf8') as file_data:
        file_data.write(str(res))
    file_data.close()


def read_file_sh(ip):
    for read_path in sh_file_list:
        if read_path.endswith("common.sh"):
            file_data = file_read(read_path)
            hostname = socket.gethostname()
            res = file_data.replace("dss.node.cn", hostname)
            file_write(read_path, res)
        if read_path.endswith("conf/config.sh"):
            update_hive_metastore(read_path)
        file_data = file_read(read_path)
        res = file_data.replace("172.17.0.5", ip)
        file_write(read_path, res)


def read_file_yml(ip):
    for yaml_path in yml_file_list:
        file = open(yaml_path, 'rb')
        data = yaml.load(file, Loader=yaml.Loader)

        if data.get("eureka").get("client").get("serviceUrl").get("defaultZone"):
            data["eureka"]["client"]["serviceUrl"]["defaultZone"] = "http://{}:9600/eureka/".format(str(ip))
        file.close()

        with open(yaml_path, 'w', encoding='utf8') as f:
            yaml.dump(data=data, stream=f, allow_unicode=True)


def update_hive_metastore(file_path):
    config = configparser.ConfigParser()
    config.read_file(open('/wedatasphere/docker/conf/conf.ini', encoding="utf-8-sig"))

    host = config.get("hiveMetaData", "hive.meta.host")
    db = config.get("hiveMetaData", "hive.meta.db")
    username = config.get("hiveMetaData", "hive.meta.user")
    pwd = config.get("hiveMetaData", "hive.meta.password")

    file_data = file_read(file_path)
    res = file_data.replace("UserHive", username).replace("123456789", pwd).replace("HiveMetastore", db). \
        replace("172.16.13.224", host)
    file_write(file_path, res)


def read_file_pro(ip):
    for pro_file in pro_file_list:
        if not pro_file.endswith("linkis-ps-publicservice.properties"):
            if pro_file.endswith("host.properties"):
                hostname = socket.gethostname()
                file_data = file_read(pro_file)
                res = file_data.replace("dss.node.cn", hostname)
                file_write(pro_file, res)
            file_data = file_read(pro_file)
            res = file_data.replace("172.17.0.5", ip).replace("172.16.13.131", ip)
            file_write(pro_file, res)
        else:
            update_hive_metastore(pro_file)


def run():
    # 获取IP地址
    ip = get_host_ip()
    # 文件分类
    file_types()
    read_file_sh(ip)
    read_file_yml(ip)
    read_file_pro(ip)
    print("配置文件更新成功")


if __name__ == "__main__":
    run()
