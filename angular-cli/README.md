# Docker image inglebard/angular-cli
Angular Cli
[Github](https://github.com/Inglebard/dockerfiles/tree/master/angular-cli)
[Dockerhub](https://hub.docker.com/r/inglebard/angular-cli)

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
You may need to mount app folder to /var/www/html.

## How to use this image :

You can create a project :
```
docker run -it -v angular_app:/var/www/html inglebard/angular-cli:latest ng new --directory . myapp
```

You can serve the project like this:
```
docker run -it -v angular_app:/var/www/html -p 4200:4200 inglebard/angular-cli:latest

```

## Note :

The default command is `ng serve --host 0.0.0.0`.
