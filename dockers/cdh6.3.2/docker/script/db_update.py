# !/usr/bin/python3
# -*- coding: utf-8 -*-
"""
@IDE     :   PyCharm
@File    :   db_update.py
@Time    :   2023-03-07 9:51
@Place   :   BeiJing
@Author  :   Zsy
@Version :   1.0
"""
import os
import pymysql
import parse_yarn_ip

table_list = [
    "dss_appconn_instance",
    "dss_workspace_dictionary",
    "dss_workspace_menu_appconn",
    "linkis_ps_bml_resources_task",
    "linkis_ps_bml_resources_version",
    "linkis_ps_dm_datasource_env",
    "linkis_cg_rm_external_resource_provider"
]


def get_host_ip():
    import socket
    # 获取计算机名称
    hostname = socket.gethostname()
    # 获取本机IP
    # ip = os.getenv("HOST_IP")
    ip = socket.gethostbyname(hostname)
    return ip


def conn_mysql():
    conn = pymysql.connect(host="127.0.0.1", port=3306, user="dss_server", password="dssServer123.",
                           db="dss_server", cursorclass=pymysql.cursors.DictCursor, charset='utf8')
    return conn


def update_ip(ip):
    db_conn = conn_mysql()
    cursor = db_conn.cursor()
    old_ip = "172.17.0.5"
    for table in table_list:
        sql = f"select * from dss_server.{table};"
        cursor.execute(sql)
        res = cursor.fetchall()
        print("更新数据库表: {}".format(table))
        if table == "dss_appconn_instance":
            for i in res:
                data = dict(i)
                url = data.get("url")
                home_page_url = data.get("homepage_uri")
                if url and old_ip in url:
                    url = url.replace(old_ip, os.getenv("HOST_IP"))
                    idx = data.get("id")
                    update_sql = f"update dss_server.{table} set url = '{url}'  where id ={idx};"
                    cursor.execute(update_sql)
                    db_conn.commit()
                if home_page_url and old_ip in home_page_url:
                    url = home_page_url.replace(old_ip, os.getenv("HOST_IP"))
                    idx = data.get("id")
                    update_sql = f"update dss_server.{table} set homepage_uri = '{url}'  where id = {idx};"
                    cursor.execute(update_sql)
                    db_conn.commit()
        if table == "dss_workspace_dictionary":
            for i in res:
                data = dict(i)
                url = data.get("url")
                if url and old_ip in url:
                    url = url.replace(old_ip, ip)
                    idx = data.get("id")
                    update_sql = f"update dss_server.{table} set url = '{url}'  where id ={idx};"
                    cursor.execute(update_sql)
                    db_conn.commit()
            pass
        if table == "dss_workspace_menu_appconn":
            for i in res:
                data = dict(i)
                manual_button_url = data.get("manual_button_url")
                if manual_button_url and old_ip in manual_button_url:
                    url = manual_button_url.replace(old_ip, ip)
                    idx = data.get("id")
                    update_sql = f"update dss_server.{table} set manual_button_url = '{url}'  where id ={idx};"
                    cursor.execute(update_sql)
                    db_conn.commit()
            pass
        if table == "linkis_ps_bml_resources_task" or table == "linkis_ps_bml_resources_version":
            update_sql = f"update dss_server.{table} set client_ip = '{ip}';"
            cursor.execute(update_sql)
            db_conn.commit()
        if table == "linkis_ps_dm_datasource_env":
            for i in res:
                data = dict(i)
                idx = data.get("id")
                parameter = data.get("parameter")
                if parameter and old_ip in parameter:
                    parameter = parameter.replace(old_ip, ip)
                    update_sql = f"update dss_server.{table} set parameter = '{parameter}' where id = {idx};"
                    cursor.execute(update_sql)
                    db_conn.commit()
        if table == "linkis_cg_rm_external_resource_provider":
            yarn_ip = parse_yarn_ip.run()
            for i in res:
                data = dict(i)
                idx = data.get("id")
                # config = data.get("config").replace("http://172.16.13.131:8088", yarn_ip)
                config = data.get("config")
                if config and "172.16.13.131" in config:
                    config = config.replace("http://172.16.13.131:8088", yarn_ip)
                    update_sql = f"update dss_server.{table} set config = '{config}' where id = {idx};"
                    cursor.execute(update_sql)
                    db_conn.commit()


def run():
    ip = get_host_ip()
    update_ip(ip)
    print("数据库更新成功")


if __name__ == "__main__":
    run()
