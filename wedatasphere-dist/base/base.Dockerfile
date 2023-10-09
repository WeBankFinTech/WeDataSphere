#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

######################################################################
# hadoop all in one image
######################################################################

ARG IMAGE_BASE=centos:7

FROM ${IMAGE_BASE} as base

ARG LINKIS_SYSTEM_USER="hadoop"
ARG LINKIS_SYSTEM_UID="1002"
ARG LINKIS_SYSTEM_GROUP="hadoop"
ARG LINKIS_SYSTEM_GID="1002"

# if you want to set specific yum repos conf file, you can put its at linkis-dist/docker/CentOS-Base.repo
# and exec [COPY  apache-linkis-*-bin/docker/CentOS-Epel.repo  /etc/yum.repos.d/CentOS-Epel.repo]

# TODO: remove install mysql client when schema-init-tools is ready
RUN set -eux; \
	    cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
        sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo && \
        yum install -y \
        less vim zip unzip gzip tar wget expect iproute openssh-server openssh-clients which binutils \
        freetype fontconfig fontconfig-devel chinese-support curl sudo pam_krb5 krb5-workstation krb5-libs krb5-auth-dialog sssd crontabs \
        telnet dos2unix sed net-tools python-pip glibc-common mysql libaio numactl initscripts psmisc\
        && yum clean all;

RUN echo -e '[nginx]\n\
name=nginx repo\n\
baseurl=http://nginx.org/packages/centos/7/$basearch/\n\
gpgcheck=0\n\
enabled=1' >> /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx &&\
    rm -rf /var/cache/yum;

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && localedef -c -f UTF-8 -i en_US en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:zh LC_TIME=en_US.UTF-8
ENV TZ="Asia/Shanghai"

RUN groupadd -g ${LINKIS_SYSTEM_GID} ${LINKIS_SYSTEM_GROUP} \
    && useradd -r -s /bin/bash -u ${LINKIS_SYSTEM_UID} -g ${LINKIS_SYSTEM_GROUP} ${LINKIS_SYSTEM_USER} -d /home/${LINKIS_SYSTEM_USER} -m \
    && echo "hadoop  ALL=(ALL)  NOPASSWD: NOPASSWD: ALL" >> /etc/sudoers \
    && echo "root   ALL=(ALL)       ALL" >> /etc/sudoers \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    #&& sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePrivilegeSeparation sandbox/UsePrivilegeSeparation no/g' /etc/ssh/sshd_config \
    #&& sed -i 's#HostKey /etc/ssh/ssh_host_ecdsa_key##g' /etc/ssh/sshd_config \
    #&& sed -i 's#HostKey /etc/ssh/ssh_host_ed25519_key##g' /etc/ssh/sshd_config \
    #&& sed -i 's/#HostKey/HostKey/g' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && mkdir /var/run/sshd \
    && echo "root:root" | chpasswd \
    && echo "hadoop:hadoop" | chpasswd
ENTRYPOINT ["/bin/bash"]