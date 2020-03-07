# Docker image inglebard/meteorjs
Meteorjs
[Github](https://github.com/Inglebard/dockerfiles/tree/master/meteorjs)
[Dockerhub](https://hub.docker.com/r/inglebard/meteorjs)

## Why use this image :

This image was created to develop Meteorjs app.

## Technical information :

### Softwares :
* node
* npm
* meteor

### Ports :
* 3000

### Volumes :
You may need to mount app folder to :
- /home/meteor/app/

## How to use this image :

You can create a project :
```
docker run -it --rm -v meteor_app:/var/www/html -p 3000:3000 inglebard/meteorjs:latest meteor create .
```
You can run the project :
```
docker run -it --rm -v meteor_app:/var/www/html -p 3000:3000 inglebard/meteorjs:latest meteor
```

## Note :

The default command is `meteor`.
