# Docker image inglebard/vue-cli
Vue Cli
[Github](https://github.com/Inglebard/dockerfiles/tree/vue-cli)
[Dockerhub](https://hub.docker.com/r/inglebard/vue-cli)

## Why use this image :

This image was created to develop vue app.

## Technical information :

### Softwares :
* node
* npm
* vue-cli

### Ports :
* 8080

### Volumes :
You may need to mount app folder to /var/www/html.

## How to use this image :

You can create a project :
```
docker run -it --rm -v vue_app:/var/www/html inglebard/vue-cli:latest vue create .
docker run -it --rm -v vue_app:/var/www/html inglebard/vue-cli:latest npm install
```

Then edit vue.config.js to have :
```
module.exports = {
  //...
  devServer: {
    host: '0.0.0.0'
  }
};
```
You can serve the project like this:
```
docker run -it -v vue_app:/var/www/html -p 8080:8080 inglebard/vue-cli:latest

```

## Note :

The default command is `npm run serve`.
