#
# MonaServer2 Dockerfile

FROM alpine

#based on https://github.com/MonaSolutions/docker-mona
#Thomas Jammet contact@monaserver.ovh

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

ENV LUAJIT_VERSION 2.1.0-beta3
ENV LUAJIT_DOWNLOAD_SHA256 1ad2e34b111c802f9d0cdf019e986909123237a28c746b21295b63c9e785d9c3
ENV MonaServer2_VERSION f7a754399c8a9e23b60ad358ef33bc408e42533e
ENV MonaServer2_DOWNLOAD_SHA256 fd176fc50b83629d13fa295c976096d943b64ce03b6b751c3dae22f05777cabf

# install prerequisites
RUN apk add --no-cache libgcc \
		libstdc++ \
		openssl-dev \
	&& apk add --no-cache --virtual .build-deps \
		curl \
		make \
		g++ \
		git \
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
	&& sed -i 's/_isInteractive = _isatty(_fileno(stdout)) ? true : false;/_isInteractive = _isatty(_fileno(stdout)) ? true : true;/g' MonaBase/sources/ConsoleLogger.cpp \
	&& sed -i 's/_isInteractive = isatty(STDOUT_FILENO) ? true : false;/_isInteractive = isatty(STDOUT_FILENO) ? true : true;/g' MonaBase/sources/ConsoleLogger.cpp \
	# don't know why /usr/local/include/ is ignored by default
	&& cd MonaBase && make && cd ../MonaCore && make && cd ../MonaServer && make INCLUDES="-I/usr/local/include/"\
	&& cp ../MonaBase/lib/libMonaBase.so ../MonaCore/lib/libMonaCore.so /usr/local/lib \
	&& cp MonaServer /usr/local/bin \
	&& rm -Rf /usr/src/MonaServer2 \
	&& apk del .build-deps

WORKDIR /usr/local/bin

EXPOSE 80 1935 554

# Set MonaServer as default executable
CMD ["./MonaServer", "--log=7"]
