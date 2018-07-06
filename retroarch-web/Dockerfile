# Run RetroArch Web Player in a container
#
# docker run --rm -it -p 8080:80 retroarch-web
#
FROM debian:stretch

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

RUN apt-get update && apt-get install -y \
	ca-certificates \
	unzip \
	sed \
	p7zip-full \
	coffeescript \
	xz-utils \
	nginx \
	wget \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# https://github.com/libretro/RetroArch/tree/master/pkg/emscripten
# https://buildbot.libretro.com/stable/
ENV RETROARCH_VERSION 1.7.3
ENV ROOT_WWW_PATH /var/www/html


RUN cd ${ROOT_WWW_PATH} \
	&& wget https://buildbot.libretro.com/stable/${RETROARCH_VERSION}/emscripten/RetroArch.7z \
	&& 7z e -y RetroArch.7z \
	&& sed -i '/<script src="analytics.js"><\/script>/d' ./index.html \
	&& chmod +x indexer \
	&& mkdir -p ${ROOT_WWW_PATH}/assets/frontend \
	&& mkdir -p ${ROOT_WWW_PATH}/assets/cores \
	&& cd ${ROOT_WWW_PATH}/assets/frontend \
	&& wget https://buildbot.libretro.com/assets/frontend/bundle.zip \
	&& unzip bundle.zip -d bundle \
	&& cd ${ROOT_WWW_PATH}/assets/frontend/bundle \
	&& ../../../indexer > .index-xhr \
    && cd ${ROOT_WWW_PATH}/assets/cores \
    && ../../indexer > .index-xhr

WORKDIR ${ROOT_WWW_PATH}

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]

