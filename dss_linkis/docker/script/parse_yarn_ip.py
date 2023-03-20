# !/usr/bin/python3
# -*- coding: utf-8 -*-
"""
@IDE     :   PyCharm
@File    :   parse_yarn_ip.py
@Time    :   2023-03-06 15:43
@Place   :   BeiJing
@Author  :   Zsy
@Version :   1.0
"""

from xml.etree.ElementTree import ElementTree


def read_xml(in_path):
    """
    读取并解析xml文件
    in_path: xml路径
    return: ElementTree
    """
    tree = ElementTree()
    tree.parse(in_path)
    return tree


def find_nodes(tree, path):
    """
    查找某个路径匹配的所有节点
    tree: xml树
    path: 节点路径
    """
    return tree.findall(path)


def get_yarn_ips(nodelist, kv_map):
    """
    获取yarn ip
    nodelist: 节点列表
    kv_map: 匹配属性及属性值map

    """
    k_list, ip_list = [], []
    for node in nodelist:
        name = node.find('name').text
        if name == kv_map.get("name"):
            for i in node.find('value').text.split(","):
                k_list.append("yarn.resourcemanager.webapp.address." + i)
    for node in nodelist:
        name = node.find('name').text
        if name in k_list:
            ip_list.append(node.find('value').text)
    return ip_list


def run():
    tree = read_xml("/wedatasphere/cdh/config/hadoop/yarn-site.xml")
    nodes = find_nodes(tree, "property")
    ips = get_yarn_ips(nodes, {"name": "yarn.resourcemanager.ha.rm-ids"})
    ips = ["http://" + ip for ip in ips if "http://" not in ip]
    return ";".join(ips)


if __name__ == "__main__":
    run()
