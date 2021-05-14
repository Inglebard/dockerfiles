# Docker image inglebard/rsyslog
rsyslog
[Github](https://github.com/Inglebard/dockerfiles/tree/rsyslog)
[Dockerhub](https://hub.docker.com/r/inglebard/rsyslog)

## Why use this image :

Based on : https://github.com/rsyslog/rsyslog-docker/tree/master/appliance
Used to log container with log driver.

## Technical information :

### Softwares :
* exim

### Ports :
* 514


## How to use this image :

You can create a project :
```
docker run -p 514:514 -it inglebard/rsyslog:latest
```
