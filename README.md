# Docker image inglebard/reactjs
Reactjs
[Github](https://github.com/Inglebard/dockerfiles/tree/master/reactjs)
[Dockerhub](https://hub.docker.com/r/inglebard/reactjs)

## Why use this image :

This image was created to develop reactjs app.

## Technical information :

### Softwares :
* node
* npm
* create-react-app

### Ports :
* 3000

### Volumes :
You may need to mount app folder to /var/www/html.

## How to use this image :

You can create a project :
```
docker run -it --rm -v react_app:/var/www/html inglebard/reactjs:latest create-react-app .
```

You can start the project like this:
```
docker run -it -v react_app:/var/www/html -p 8080:8080 inglebard/reactjs:latest
```

## Note :

The default command is `npm start`.
