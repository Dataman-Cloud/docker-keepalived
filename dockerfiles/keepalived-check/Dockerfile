FROM shurenyun/centos7-keepalived-1.2.13
MAINTAINER jyliu <jyliu@dataman-inc.com>

#RUN yum install -y mysql &&\
#    yum clean all
#ADD keepalived-scripts.tar.gz  /etc/keepalived/
COPY /etc/ /etc/
COPY entrypoint.sh /

RUN chmod -R 755 /etc/keepalived/scripts /etc/keepalived/build_config.sh /entrypoint.sh
ENV TERM dumb

ENTRYPOINT ["/entrypoint.sh"]
