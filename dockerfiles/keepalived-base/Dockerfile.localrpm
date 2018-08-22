FROM demoregistry.dataman-inc.com/library/centos7-base:latest
MAINTAINER jyliu <jyliu@dataman-inc.com>


COPY keepalived-1.3.5-2.x86_64.rpm /

RUN yum -y install /keepalived-1.3.5-2.x86_64.rpm && yum clean all && rm -f /keepalived-1.3.5-2.x86_64.rpm

