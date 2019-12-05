# Run tor browser in a container
#
# docker run -t -i --rm --volume=$XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v /dev/shm:/dev/shm \
# -e DISPLAY=unix$DISPLAY \
# -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
# inglebard/tor-browser
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
	file \
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
	libcanberra-gtk-module \
	libcanberra-gtk3-module \
	xz-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

ENV LANG C.UTF-8

# https://www.torproject.org/projects/torbrowser.html.en
ENV TOR_VERSION 9.0.2
ENV TOR_LANG en-US
# ENV TOR_FINGERPRINT 0x4E2C6E8793298290

# download tor and check signature
RUN cd /tmp \
	&& mkdir /opt/tor-browser \
	&& chmod 1777 /opt/tor-browser \
	&& curl -sSOL "https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux64-${TOR_VERSION}_${TOR_LANG}.tar.xz" \
	&& tar -vxJ --strip-components 1 -C /opt/tor-browser -f tor-browser-linux64-${TOR_VERSION}_${TOR_LANG}.tar.xz \
	&& chown -R user:user /opt/tor-browser/* \
	&& rm -rf tor-browser*
#	&& curl -sSOL "https://www.torproject.org/dist/torbrowser/${TOR_VERSION}/tor-browser-linux64-${TOR_VERSION}_${TOR_LANG}.tar.xz.asc" \
#	&& mkdir ~/.gnupg \
#	&& gpg --no-tty --keyserver "hkp://pool.sks-keyservers.net" --recv-keys ${TOR_FINGERPRINT} \
#	&& gpg --fingerprint --keyid-format LONG ${TOR_FINGERPRINT} | grep "Key fingerprint = EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290" \
#	&& gpg --verify tor-browser-linux64-${TOR_VERSION}_${TOR_LANG}.tar.xz.asc \
#	&& tar -vxJ --strip-components 1 -C /opt/tor-browser -f tor-browser-linux64-${TOR_VERSION}_${TOR_LANG}.tar.xz \
#	&& rm -rf tor-browser* \
#	&& rm -rf ~/.gnupg

# Not sure if usefull with PULSE_SERVER
# COPY pulse-client.conf /etc/pulse/client.conf

# good fonts
COPY local.conf /etc/fonts/local.conf

WORKDIR $HOME
USER user

#debug
#CMD ["pacat", "-vvvv", "/dev/urandom"]

ENTRYPOINT ["/bin/bash"]
CMD [ "/opt/tor-browser/Browser/start-tor-browser", "--log", "/dev/stdout" ]
