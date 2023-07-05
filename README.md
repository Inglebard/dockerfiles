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

To add your own model files you can mount a volume similar to `./models:/opt/easy-diffusion/models`

And you should propably pass the GPU. If you use an nvidia GPU as they are the most compatible with stable-diffusion-ui at the time of this writing, please consult how to set up an NVIDIA-Container at their [Github](https://github.com/NVIDIA/nvidia-container-runtime#installation)
The steps consist mostly of:
1. Adding the NVIDIA Repository
2. Installing the nvidia-container-runtime
3. Installing nvidia-docker2 or modifying your Docker Daemon



## How to use this image :

You can run this image directly like this:
```
docker run -t -i --rm \
-v /dev/shm:/dev/shm \
-p 9000:9000 \
inglebard/stable-diffusion-ui

```

or a Docker Compose File may look like this:
```
version: "3"
services:
  stable-diffusion-ui:
    image: inglebard/stable-diffusion-ui
    container_name: stable-diffusion-ui
    ports:
      - 9000:9000
    volumes:
      - '/dev/shm:/dev/shm'
      - ./models:/opt/easy-diffusion/models
    deploy:
        resources:
          reservations:
            devices:
              - driver: nvidia
                device_ids: ['0']
                capabilities: [gpu]
```

## Thanks
This image was created from
* https://github.com/cmdr2/stable-diffusion-ui
