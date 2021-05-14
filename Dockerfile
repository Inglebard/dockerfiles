# rsyslog in a container
#
# docker run -it inglebard/rsyslog:latest
#
# Based on : https://github.com/rsyslog/rsyslog-docker/tree/master/appliance

FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
	rsyslog \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /logs/{local,remote} && mkdir /work  && chown syslog:syslog -R /{logs,work}

COPY entrypoint.sh /entrypoint.sh
COPY rsyslog.conf /etc/rsyslog.conf
COPY 50-default.conf /etc/rsyslog.d/50-default.conf

RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
