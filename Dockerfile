#
# MonaServer2 Dockerfile
# https://github.com/MonaSolutions/MonaServer2
# docker run -it --name Mona -p 80:80 -p 1935:1935 -p 554:554 -p 1935:1935/udp inglebard/monaserver2


FROM alpine

#based on https://github.com/MonaSolutions/docker-mona
#Thomas Jammet contact@monaserver.ovh

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

ENV LUAJIT_VERSION 2.1.0-beta3
ENV LUAJIT_DOWNLOAD_SHA256 1ad2e34b111c802f9d0cdf019e986909123237a28c746b21295b63c9e785d9c3
ENV MonaServer2_VERSION 864384eb7ee4037830da593f439a4d656d297e00
ENV MonaJS_VERSION a2684c87cf1addf2bad89d726006aed8be24c789

COPY ./monajsdockerpatch.diff /monajsdockerpatch.diff

# install prerequisites
RUN apk add --no-cache libgcc \
		libstdc++ \
		openssl-dev \
	&& apk add --no-cache --virtual .build-deps \
		curl \
		make \
		g++ \
		git \
		diffutils \
# Build & install luajit
	&& mkdir -p /usr/src \
	&& cd /usr/src \
	&& curl -fSL -o luajit.tar.gz http://luajit.org/download/LuaJIT-$LUAJIT_VERSION.tar.gz \
	&& echo "$LUAJIT_DOWNLOAD_SHA256 *luajit.tar.gz" | sha256sum -c \
	&& tar -xzf luajit.tar.gz \
	&& rm luajit.tar.gz \
	&& cd LuaJIT-$LUAJIT_VERSION \
	&& sed -i 's/#XCFLAGS+= -DLUAJIT_ENABLE_LUA52COMPAT/XCFLAGS+= -DLUAJIT_ENABLE_LUA52COMPAT/g' src/Makefile \
	&& make \
	&& make install \
	# Correction of luajit-2.0.4 link name (TODO: delete it on next version)
	# && ln -s /usr/local/lib/libluajit-5.1.so.2.0.4 /usr/local/lib/libluajit-5.1.so.2 \
	&& ln -sf luajit-2.1.0-beta3 /usr/local/bin/luajit \
	&& cd ../ \
	&& rm -Rf LuaJIT-$LUAJIT_VERSION \
# Build & install MonaServer
#	&& curl -SL -o mona.tar.gz https://github.com/MonaSolutions/MonaServer/archive/$MONA_VERSION.tar.gz \
#	&& echo "$MONA_DOWNLOAD_SHA256 *mona.tar.gz" | sha256sum -c \
#	&& tar -xzf mona.tar.gz \
#	&& rm mona.tar.gz \
	&& git clone https://github.com/MonaSolutions/MonaServer2.git \
	&& cd MonaServer2 \
	&& git checkout "$MonaServer2_VERSION" \
	&& sed -i 's/bool enabled() const { return _isInteractive; }/bool enabled() const { return true; }/g' MonaBase/include/Mona/ConsoleLogger.h \
	# don't know why /usr/local/include/ is ignored by default
	&& cd MonaBase && make && cd ../MonaCore && make && cd ../MonaServer && make INCLUDES="-I/usr/local/include/"\
	&& cp ../MonaBase/lib/libMonaBase.so ../MonaCore/lib/libMonaCore.so /usr/local/lib \
	&& cp MonaServer /usr/local/bin \
	&& rm -Rf /usr/src/MonaServer2 \
	&& mkdir -p /usr/local/bin/www/live \
	&& cd /usr/local/bin/www \
	&& git clone https://github.com/MonaSolutions/MonaJS.git \
	&& cd MonaJS \
	&& git checkout "$MonaJS_VERSION" \
	&& git apply /monajsdockerpatch.diff \
	&& rm /monajsdockerpatch.diff \
	&& apk del .build-deps

WORKDIR /usr/local/bin

EXPOSE 80 1935 554

# Set MonaServer as default executable
CMD ["./MonaServer", "--log=7"]
