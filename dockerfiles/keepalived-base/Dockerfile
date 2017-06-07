FROM demoregistry.dataman-inc.com/library/centos7-base:latest
MAINTAINER jyliu <jyliu@dataman-inc.com>

# /usr/sbin/keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console


RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7
#RUN yum -y  update;yum clean all

RUN yum -y install keepalived && yum clean all

