
# exim in a container
#
# docker run -it inglebard/exim:latest
#

FROM ubuntu:23.04

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
	exim4 \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY update-exim4.conf.conf /etc/exim4/update-exim4.conf.conf

RUN update-exim4.conf
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
