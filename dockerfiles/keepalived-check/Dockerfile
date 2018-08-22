FROM shurenyun/centos7-keepalived-1.3.5
MAINTAINER jyliu <jyliu@dataman-inc.com>

#RUN yum install -y mysql &&\
#    yum clean all
#ADD keepalived-scripts.tar.gz  /etc/keepalived/
COPY /etc/ /etc/
COPY entrypoint.sh /

# add filedownload script
ADD https://raw.githubusercontent.com/Dataman-Cloud/OpenDockerFile/master/basefile/scripts/DM_DOCKER_URI_2.7.py /DM_DOCKER_URI.py
ADD https://raw.githubusercontent.com/Dataman-Cloud/OpenDockerFile/master/basefile/scripts/filedownload.sh /filedownload.sh
RUN chmod +x /*.py /*.sh && chmod -R 755 /etc/keepalived/scripts /etc/keepalived/build_config.sh /entrypoint.sh
ENV TERM dumb

ENTRYPOINT ["/entrypoint.sh"]
