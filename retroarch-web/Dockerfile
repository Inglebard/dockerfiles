# Run RetroArch Web Player in a container
#
# docker run --rm -it -p 8080:80 archretro-web
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
ENV RETROARCH_VERSION 1.7.0

RUN cd /var/www/html \
	&& wget https://buildbot.libretro.com/stable/${RETROARCH_VERSION}/emscripten/RetroArch.7z \
	&& 7z e -y RetroArch.7z \
	&& sed -i '/<script src="analytics.js"><\/script>/d' ./index.html \
	&& sed -i -e 's/bot.libretro.com\/web\/browserfs.min.js/bot.libretro.com\/.web\/browserfs.min.js/g' ./index.html \
	&& mkdir -p /usr/share/nginx/html/assets/frontend \
	&& mkdir -p /usr/share/nginx/html/assets/cores \
	&& cd /usr/share/nginx/html/assets/frontend \
	&& wget https://buildbot.libretro.com/assets/frontend/bundle.zip \
	&& unzip bundle.zip

WORKDIR /var/www/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]

