# Docker image inglebard/angular
Angular
[Github](https://github.com/Inglebard/dockerfiles/blob/master/retroarch-web/)
[Dockerhub](https://hub.docker.com/r/inglebard/retroarch-web/)

## Why use this image :

This image was created to develop angular app.

## Technical information :

### Softwares :
* node
* npm
* @angular/cli

### Ports :
* 4200

### Volumes :
You may need to mount game app folder to /var/www/html.

## How to use this image :

You can run this image like this:
```
docker run -it -v angular_app:/var/www/html -p 4200:4200 angular:7.3.5

```

## Note :

The default command is `ng serve --host 0.0.0.0`.
