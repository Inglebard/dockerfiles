# Sails in a container
#
# docker run -it -v sails_app:/var/www/html -p 4200:4200 inglebard/sails:latest
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_WWW_PATH /var/www/html
ENV SAILS_VERSION 1.2.3

RUN npm install -g sails@${SAILS_VERSION} \
  && rm -rf /tmp/* ~/.npm \
  && npm cache clear --force \
  && mkdir -p /var/www/html

WORKDIR ${ROOT_WWW_PATH}


EXPOSE 4200


CMD [ "sails", "lift" ]
