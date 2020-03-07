# MeteorJs in a container
#
# docker run -it -v meteor_app:/home/meteor/app -p 3000:3000 inglebard/meteorjs:latest meteor
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_APP_PATH /home/meteor/app
ENV METOR_CONFIG_PATH /home/meteor/.meteor
ENV NODE_ENV development

RUN apt-get update \
  && apt-get install -yq curl \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash meteor \
  && curl https://install.meteor.com/ | sh \
  && mkdir -p ${ROOT_APP_PATH} \
  && chown meteor:meteor ${ROOT_APP_PATH}

USER meteor
WORKDIR ${ROOT_APP_PATH}


EXPOSE 3000


CMD [ "sh", "-c", "meteor" ]
