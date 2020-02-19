# Docker image inglebard/steam
Steam
[Github](https://github.com/Inglebard/dockerfiles/blob/master/steam/)
[Dockerhub](https://hub.docker.com/r/inglebard/steam/)

## Why use this image :

I don't know.

## Technical information :

### Softwares :
* steam

### Ports :
* none

### Volumes :
* /home/steam


### Notes :
* This was only test with opensource intel driver. You may encouter issue with NVIDIA or AMD.

## How to use this image :

You can run this image like this:
```
docker run -t -i --rm --volume=$XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/shm:/dev/shm \
-e DISPLAY=unix$DISPLAY \
-e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
inglebard/steam

```

## Thanks
This image was created from
* "Tianon Gravi aka tianon https://hub.docker.com/r/tianon/steamos/
