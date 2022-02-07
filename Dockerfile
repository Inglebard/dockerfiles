# forked from https://github.com/mattikus/docker-murmur

FROM busybox:latest

#original dockerfile from "Matt Kemp <matt@mattikus.com>"
LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

ENV MURMUR_VERSION 1.4.230

# Download statically compiled murmur and install it to /opt/murmur
ADD https://github.com/mumble-voip/mumble/releases/download/${MURMUR_VERSION}/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 /opt/
RUN bzcat /opt/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 | tar -x -C /opt -f - && \
    rm /opt/murmur-static_x86-${MURMUR_VERSION}.tar.bz2 && \
    mv /opt/murmur-static_x86-${MURMUR_VERSION} /opt/murmur && \
    mkdir /opt/murmur/data && \
    cp /opt/murmur/murmur.ini /opt/murmur/data/murmur.ini

# Forward apporpriate ports
#EXPOSE 64738/tcp 64738/udp

CMD ["/opt/murmur/murmur.x86", "-fg", "-v","-ini", "/opt/murmur/data/murmur.ini"]
