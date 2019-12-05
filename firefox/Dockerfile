# Run tor browser in a container
#
# docker run -t -i --rm --volume=$XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v /dev/shm:/dev/shm \
# -e DISPLAY=unix$DISPLAY \
# -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
# inglebard/firefox
#
FROM debian:buster

#original dockerfile from "Jessie Frazelle <jess@linux.com>" https://hub.docker.com/r/jess/tor-browser/
# and Guy Taylor <thebigguy.co.uk@gmail.com> https://github.com/TheBiggerGuy/docker-pulseaudio-example
LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

# add pulseaudio-utils for pacat
RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	dirmngr \
	gnupg \
	libasound2 \
	libdbus-glib-1-2 \
	libgtk-3-0 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libxrender1 \
	libx11-xcb-dev \
	libx11-xcb1 \
	libxt6 \
	libpulse0 \
	bzip2 \
	libcanberra-gtk-module \
	libcanberra-gtk3-module \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

ENV LANG C.UTF-8

#https://download-installer.cdn.mozilla.net/pub/firefox/releases/
ENV FIREFOX_VERSION 71.0
ENV FIREFOX_LANG en-US

# download tor and check signature
RUN cd /tmp \
	&& curl -sSOL "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/${FIREFOX_LANG}/firefox-${FIREFOX_VERSION}.tar.bz2" \
	&& tar -vxj -C /opt -f firefox-${FIREFOX_VERSION}.tar.bz2 \
	&& rm -rf firefox-${FIREFOX_VERSION}.tar.bz2

# Not sure if usefull
# COPY pulse-client.conf /etc/pulse/client.conf

# good fonts
COPY local.conf /etc/fonts/local.conf

WORKDIR $HOME
USER user

#debug
#CMD ["pacat", "-vvvv", "/dev/urandom"]
ENTRYPOINT [ "/opt/firefox/firefox" ]
