# Docker image inglebard/murmur
murmur
[Github](https://github.com/Inglebard/dockerfiles/tree/master/murmur)
[Dockerhub](https://hub.docker.com/r/inglebard/murmur)

## Why use this image :

This image was created to run murmur with latest version.
This directory is a fork from from https://github.com/mattikus/docker-murmur

## Technical information :

### Softwares :
* murmur

### Ports :
* Your must specify the exact same port from /opt/murmur/data/murmur.ini in tcp and udp

### Volumes :
You may need to have something like this :
* murmur-data:/opt/murmur/data

## Note :

You may want to edit '/opt/murmur/data/murmur.ini' before the first run.
You can do it like that  `docker run --rm -it -v mumble-data:/opt/murmur/data inglebard/murmur sh` and then `vi /opt/murmur/data/murmur.ini`


## How to use this image :

```docker run --rm -it -v mumble-data:/opt/murmur/data -p 64738:64738/tcp -p 64738:64738/udp inglebard/murmur```
