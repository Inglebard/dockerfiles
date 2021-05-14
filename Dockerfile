# sendmail in a container
#
# docker run -it inglebard/sendmail:latest
#

FROM ubuntu:20.04

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
	sendmail \
	openssl \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY sendmail.mc /etc/mail/sendmail.mc
COPY access /etc/mail/access

RUN chmod u+x /entrypoint.sh
RUN makemap hash /etc/mail/access < /etc/mail/access
RUN export DEBIAN_FRONTEND=noninteractive | /usr/sbin/sendmailconfig --no-reload
ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
