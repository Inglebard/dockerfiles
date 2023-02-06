# forked from https://github.com/jessfraz/dockerfiles
# run a tor relay in a container
#
# Bridge relay:
#	docker run -d \
#		--restart always \
#		-v /etc/localtime:/etc/localtime:ro \
#		-p 9001:9001 \
# 		--name tor-relay \
# 		jess/tor-relay -f /etc/tor/torrc.bridge
#
# Exit relay:
# 	docker run -d \
#		--restart always \
#		-v /etc/localtime:/etc/localtime:ro \
#		-p 9001:9001 \
# 		--name tor-relay \
# 		jess/tor-relay -f /etc/tor/torrc.exit
#
FROM alpine:edge

#original dockerfile from "Jessie Frazelle <jess@linux.com>" https://github.com/jessfraz/dockerfiles/tree/master/tor-relay
LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

ENV TOR_VERSION 0.4.7.13

RUN adduser -S -D -H -h /var/lib/tor -s /sbin/nologin -g tor tor 2>/dev/null \
	&& mkdir /src \
	&& cd /src \
	&& apk add --no-cache bash build-base autoconf automake libevent-dev git libcap-dev libseccomp-dev libevent-dev openssl1.1-compat-dev ca-certificates zlib-dev xz-dev zstd-dev \
	&& git clone https://git.torproject.org/tor.git \
	&& cd tor \
	&& git checkout tags/tor-${TOR_VERSION} \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --mandir=/usr/share/man --disable-html-manual --disable-asciidoc \
	&& make \
	&& make install \
	&& cd / \
	&& rm -r /src

# default port to used for incoming Tor connections
# can be changed by changing 'ORPort' in torrc
EXPOSE 9001

# copy in our torrc files
COPY torrc.bridge /etc/tor/torrc.bridge
COPY torrc.middle /etc/tor/torrc.middle
COPY torrc.exit /etc/tor/torrc.exit

# copy the run script
COPY run.sh /run.sh
RUN chmod ugo+rx /run.sh

# default environment variables
ENV RELAY_NICKNAME hacktheplanet
ENV RELAY_TYPE middle
ENV RELAY_BANDWIDTH_RATE 100 KBytes
ENV RELAY_BANDWIDTH_BURST 200 KBytes
ENV RELAY_PORT 9001

# make sure files are owned by tor user
RUN chown -R tor /etc/tor
RUN mkdir -p /var/lib/tor/.tor
RUN chown -R tor /var/lib/tor

USER tor

VOLUME /var/lib/tor/.tor

ENTRYPOINT [ "/run.sh" ]
