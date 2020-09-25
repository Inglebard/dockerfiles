# Docker image inglebard/tor-browser
Another tor-browser image. Tested on archlinux with pulseaudio
[Github](https://github.com/Inglebard/dockerfiles/tree/tor-browser/)
[Dockerhub](https://hub.docker.com/r/inglebard/tor-browser/)

## Why use this image :

This image was created to have sound with tor-browser on archlinux and pulseaudio.

## Technical information :

### Users :
* user : standard user

### Softwares :
* tor-browser

### Ports :
* no port expose

### Environnment variables :
You need to specify display variable and pulse audio variable :
* DISPLAY
* PULSE_SERVER

### Volumes :
You need to specify X11 variable and pulse audio variable :
* $XDG_RUNTIME_DIR/pulse (/run/user/1000/pulse)
* /tmp/.X11-unix
* /dev/shm

## How to use this image :

You can run this image like this:
```
docker run -t -i --rm -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/shm:/dev/shm \
-e DISPLAY=unix$DISPLAY \
-e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
inglebard/tor-browser --class=tor-docker

```

## Thanks
This image was created from
* "Jessie Frazelle <jess@linux.com>" https://hub.docker.com/r/jess/tor-browser/
* "Guy Taylor <thebigguy.co.uk@gmail.com>" https://github.com/TheBiggerGuy/docker-pulseaudio-example
