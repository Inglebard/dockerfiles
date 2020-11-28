# Meteor in a container
#
# docker run -it -v meteor_app:/home/meteor/app -p 3000:3000 inglebard/meteor:latest meteor
#
FROM debian:buster

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_APP_PATH /home/meteor/app
ENV METEOR_CONFIG_PATH_TMP /tmp/meteorconfigtmp
ENV NODE_ENV development
ENV METEOR_VERSION 1.11.1


RUN apt-get update \
  && apt-get install -yq curl procps \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash meteor \
  && curl https://install.meteor.com/ | sh \
  && mkdir -p ${ROOT_APP_PATH} \
  && chown meteor:meteor ${ROOT_APP_PATH} \
  && mkdir -p ${METEOR_CONFIG_PATH_TMP} \
  && chown meteor:meteor ${METEOR_CONFIG_PATH_TMP}

USER meteor
WORKDIR ${ROOT_APP_PATH}

COPY meteordockerinit.bash /meteordockerinit.bash


EXPOSE 3000


CMD [ "sh", "-c", "meteor" ]
