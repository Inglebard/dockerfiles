FROM ubuntu:focal

#original dockerfile from "https://github.com/mumble-voip/mumble/blob/master/Dockerfile"
LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

ENV MURMUR_VERSION 1.4.230

# needed to install tzdata
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
	ca-certificates \
	git \
	build-essential \
	cmake \
	qt5-default \
	pkg-config \
	libboost-dev \
	libasound2-dev \
	libssl-dev \
	libspeechd-dev \
	libzeroc-ice-dev \
	libpulse-dev \
	libcap-dev \
	libprotobuf-dev \
	protobuf-compiler \
	protobuf-compiler-grpc \
	libprotoc-dev \
	libogg-dev \
	libavahi-compat-libdnssd-dev \
	libsndfile1-dev \
	libgrpc++-dev \
	libxi-dev \
	libbz2-dev \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /root/ && git clone https://github.com/mumble-voip/mumble.git && cd /root/mumble && git checkout tags/v${MURMUR_VERSION}
WORKDIR /root/mumble/build

RUN git submodule update --init --recursive
RUN cmake -Dclient=OFF -DCMAKE_BUILD_TYPE=Release -Dgrpc=ON .. || \
    ( cat \
    /root/mumble/build/CMakeFiles/CMakeOutput.log \
    /root/mumble/build/CMakeFiles/CMakeError.log \
    && false \
    )
RUN make -j $(nproc)

# Clean distribution stage
FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN adduser murmur
RUN apt-get update && apt-get install --no-install-recommends -y \
	libcap2 \
	libzeroc-ice3.7 \
	'^libprotobuf[0-9]+$' \
	'^libgrpc[0-9]+$' \
	libgrpc++1 \
	libavahi-compat-libdnssd1 \
	libqt5core5a \
	libqt5network5 \
	libqt5sql5 \
	libqt5sql5-mysql \
	libqt5sql5-psql \
	libqt5sql5-sqlite \
	libqt5xml5 \
	libqt5dbus5 \
	ca-certificates \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=0 /root/mumble/build/mumble-server /usr/bin/mumble-server
COPY --from=0 /root/mumble/scripts/murmur.ini /etc/murmur/murmur.ini

RUN mkdir /var/lib/murmur && \
	chown --verbose murmur:murmur /var/lib/murmur && \
	mkdir /opt/murmur/data && \
	chown --verbose murmur:murmur /opt/murmur/data

COPY --from=0 /root/mumble/scripts/murmur.ini /opt/murmur/data/murmur.ini


RUN sed -i 's/^database=$/database=\/opt\/murmur\/data\/murmur.sqlite/' /etc/murmur/murmur.ini

EXPOSE 64738/tcp 64738/udp 50051
USER murmur

CMD bash -c "/usr/bin/mumble-server -v -fg -ini /opt/murmur/data/murmur.ini"
