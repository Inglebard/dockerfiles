# Docker image inglebard/monaserver2
monaserver2
[Github](https://github.com/Inglebard/dockerfiles/tree/master/monaserver2)
[Dockerhub](https://hub.docker.com/r/inglebard/monaserver2)

## Why use this image :

This image was created to use monaserver2.

## Technical information :

### Softwares :
* monaserver2

### Ports :
* 80
* 554
* 1935/udp
* 1935

### Volumes :
You may need to mount app folder to /usr/local/bin/www.

## How to use this image :

You can launch monaserver2 :
```
docker run -it --name Mona -p 80:80 -p 1935:1935 -p 554:554 -p 1935:1935/udp inglebard/monaserver2
```

## Note :

The default command is `./MonaServer --log=7`.
