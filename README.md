# Docker image inglebard/meteor
Meteor
[Github](https://github.com/Inglebard/dockerfiles/tree/meteor)
[Dockerhub](https://hub.docker.com/r/inglebard/meteor)

## Why use this image :

This image was created to develop Meteor app.

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
docker run -it --rm -v meteor_config:/tmp/meteorconfigtmp inglebard/meteor:latest bash /meteordockerinit.bash /tmp/meteorconfigtmp
```

You can create a project :
```
docker run -it --rm -v  meteor_config:/home/meteor/.meteor -v meteor_app:/home/meteor/app/ inglebard/meteor:latest meteor create .
```

You can run the project :
```
docker run -it --rm -v  meteor_config:/home/meteor/.meteor -v meteor_app:/home/meteor/app/ -p 3000:3000 inglebard/meteor:latest
```

## Note :

The default command is `meteor`.
