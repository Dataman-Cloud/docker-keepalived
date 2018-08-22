FROM centos:7
MAINTAINER jyliu <jyliu@dataman-inc.com>

RUN INSTALL_PKGS="kmod keepalived iproute psmisc nmap-ncat net-tools ipset ipset-libs" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all

EXPOSE 1985
