# Docker image inglebard/stable-diffusion-ui
[Github](https://github.com/Inglebard/dockerfiles/tree/stable-diffusion-ui)
[Dockerhub](https://hub.docker.com/r/inglebard/stable-diffusion-ui/)

## Why use this image :

This image was created to have a docker image of https://github.com/cmdr2/stable-diffusion-ui
## Technical information :

### Users :
* user : standard user

### Softwares :
* cmdr2/stable-diffusion-ui

### Ports :
* cmdr2/stable-diffusion-ui expose port on 9000

### Volumes :
You may need :
* /opt/easy-diffusion/
* /dev/shm

And you should propably pass the GPU


## How to use this image :

You can run this image like this:
```
docker run -t -i --rm \
-v /dev/shm:/dev/shm \
-p 9000:9000 \
inglebard/stable-diffusion-ui

```

## Thanks
This image was created from
* https://github.com/cmdr2/stable-diffusion-ui
