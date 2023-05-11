FROM centos:7

# Install necessary packages
RUN yum install -y epel-release openssh-server openssh-clients unzip zip which sudo libaio numactl nginx fontconfig-devel && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    groupadd hadoop && \
    useradd -m -g hadoop hadoop && \
    echo "hadoop ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
COPY --chown=hadoop:hadoop all /data/
USER hadoop
RUN mkdir -p /home/hadoop/.ssh && \
    ssh-keygen -t rsa -b 2048 -f /home/hadoop/.ssh/id_rsa -N '' && \
    cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys && \
    chmod 700 /home/hadoop/.ssh && \
    chmod 600 /home/hadoop/.ssh/authorized_keys && \
    ssh-keyscan 0.0.0.0 >> /home/hadoop/.ssh/known_hosts && \
    chmod 600 /home/hadoop/.ssh/known_hosts
USER root
