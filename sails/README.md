# Docker image inglebard/angular
Sails
[Github](https://github.com/Inglebard/dockerfiles/tree/master/sails)
[Dockerhub](https://hub.docker.com/r/inglebard/sails)

## Why use this image :

This image was created to develop sails app.

## Technical information :

### Softwares :
* node
* npm
* sails

### Ports :
* 1337

### Volumes :
You may need to mount game app folder to /var/www/html.

## How to use this image :

You can create a project :
```
docker run -it -v sails_app:/var/www/html inglebard/sails:latest sails new /var/www/html
```

You can serve the project like this:
```
docker run -it -v sails_app:/var/www/html -p 4200:4200 inglebard/sails:latest

```

## Note :

The default command is `sails lift`.
