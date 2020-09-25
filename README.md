# Docker image inglebard/monaserver2
MonaServer2
[Github](https://github.com/Inglebard/dockerfiles/tree/monaserver2)
[Dockerhub](https://hub.docker.com/r/inglebard/monaserver2)

## Why use this image :

This image was created to use MonaServer2.

## Technical information :

### Softwares :
* MonaServer2 (https://github.com/MonaSolutions/MonaServer2)
* MonaJS (https://github.com/MonaSolutions/MonaJS)

### Ports :
* 80
* 554
* 1935/udp
* 1935

### Volumes :
/usr/local/bin/www contain MonaJS and an empty directory .

## How to use this image :

You can launch monaserver2 :
```
docker run -it --name Mona -p 80:80 -p 1935:1935 -p 554:554 -p 1935:1935/udp inglebard/monaserver2
```

You can access to MonaJS like this : http://<dockerip>:<docker port>/Media/live.html?<steamkey>
You can access to a flux like this : rtmp:///<dockerip>:<docker port>/live/<steamkey>

## Note :

The default command is `./MonaServer --log=7`.
