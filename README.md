# Docker image inglebard/retroarch-web
Self-hosted retroarch web player.
[Github](https://github.com/Inglebard/dockerfiles/tree/retroarch-web/)
[Dockerhub](https://hub.docker.com/r/inglebard/retroarch-web/)

## Why use this image :

This image was created to have remote play to retro game.

## Technical information :

### Softwares :
* nginx

### Ports :
* 80

### Volumes :
You may need to mount game folder

## How to use this image :

You can run this image like this:
```
docker run --rm -it -p 8080:80 inglebard/retroarch-web

```

## Thanks
This image was created from
* https://github.com/libretro/RetroArch/tree/master/pkg/emscripten
