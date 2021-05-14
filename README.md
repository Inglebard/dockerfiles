# Docker image inglebard/sendmail
sendmail
[Github](https://github.com/Inglebard/dockerfiles/tree/sendmail)
[Dockerhub](https://hub.docker.com/r/inglebard/sendmail)

## Why use this image :

This image was created to be used with msmtp

## Technical information :

### Softwares :
* sendmail
* openssl

### Ports :
* 25


## How to use this image :

You can create a project :
```
docker run -it -p 25:25 inglebard/sendmail:latest
```
