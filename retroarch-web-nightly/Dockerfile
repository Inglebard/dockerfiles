# Run RetroArch Web Player in a container
#
# docker run --rm -it -p 8080:80 retroarch-web-nightly
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
# https://buildbot.libretro.com/nightly/

RUN cd /var/www/html \
	&& wget https://buildbot.libretro.com/nightly/emscripten/$(date +%Y-%m-%d)_RetroArch.7z \
	&& 7z e -y $(date +%Y-%m-%d)_RetroArch.7z \
	&& sed -i '/<script src="analytics.js"><\/script>/d' ./index.html \
	&& chmod +x indexer \
	&& mkdir -p /var/www/html/assets/frontend \
	&& mkdir -p /var/www/html/assets/cores \
	&& cd /var/www/html/assets/frontend \
	&& wget https://buildbot.libretro.com/assets/frontend/bundle.zip \
	&& unzip bundle.zip \
	&& cd /var/www/html \
	&& ./indexer ./assets/frontend > ./assets/frontend/.index-xhr \
	&& ./indexer ./assets/cores > ./assets/cores/.index-xhr

WORKDIR /var/www/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]

