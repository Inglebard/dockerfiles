# Sails in a container
#
# docker run -it -v sails_app:/var/www/html -p 4200:4200 inglebard/sails:latest
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_WWW_PATH /var/www/html
ENV SAILS_VERSION 1.5.8

RUN npm install -g sails@${SAILS_VERSION} \
  && rm -rf /tmp/* ~/.npm \
  && npm cache clear --force \
  && mkdir -p ${ROOT_WWW_PATH} \
  && chown node:node -R ${ROOT_WWW_PATH}

WORKDIR ${ROOT_WWW_PATH}

USER node

EXPOSE 4200


CMD [ "sails", "lift" ]
