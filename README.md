# Docker image inglebard/meteorjs
Meteorjs
[Github](https://github.com/Inglebard/dockerfiles/tree/master/meteorjs)
[Dockerhub](https://hub.docker.com/r/inglebard/meteorjs)

## Why use this image :

This image was created to develop Meteorjs app.

## Technical information :

### Softwares :
* meteor

### Ports :
* 3000

### Volumes :
You may need to mount app folder to :
- /home/meteor/app/
- /home/meteor/.meteor/

## How to use this image :

You may want to keep .meteor directory (this will copy .meteor) to avoid donwload meteor each time :
```
docker run -it --rm -v meteor_config:/tmp/meteorconfigtmp inglebard/meteorjs:latest bash /meteordockerinit.bash /tmp/meteorconfigtmp
```

You can create a project :
```
docker run -it --rm -v  meteor_config:/home/meteor/.meteor -v meteor_app:/home/meteor/app/ inglebard/meteorjs:latest meteor create .
```

You can run the project :
```
docker run -it --rm -v  meteor_config:/home/meteor/.meteor -v meteor_app:/home/meteor/app/ -p 3000:3000 inglebard/meteorjs:latest
```

## Note :

The default command is `meteor`.
