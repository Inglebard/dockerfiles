# docker run -t -i --rm --volume=$XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v /dev/shm:/dev/shm \
# -e DISPLAY=unix$DISPLAY \
# -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
# inglebard/steam
#

# This image was tested with opensource driver. AMD or NVIDIA drivers may failed
# Require ubuntu 18.04, issue with 16.04 and debconf-set-selections with docker
FROM ubuntu

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN echo steam steamcmd/question select "I AGREE" | debconf-set-selections

RUN dpkg --add-architecture i386

RUN apt-get update && DEBIAN_FRONTEND=noninteractive  apt-get install -y \
	steam \
	steamcmd \
	sudo \
	ca-certificates \
	curl \
	dirmngr \
	gnupg \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libgl1-mesa-dri:i386 \
	libgl1-mesa-glx:i386 \
	libc6:i386 \
	libxrender1 \
	libx11-xcb-dev \
	libx11-xcb1 \
	libxt6 \
	libpulse0 \
	bzip2 \
&& rm -rf /var/lib/apt/lists/*

RUN echo 'steam ALL = NOPASSWD: ALL' > /etc/sudoers.d/steam && chmod 0440 /etc/sudoers.d/steam
RUN adduser --disabled-password --gecos 'Steam' steam && \
adduser steam video

USER steam

ENV HOME /home/steam

VOLUME /home/steam

CMD ["/usr/games/steam"]
