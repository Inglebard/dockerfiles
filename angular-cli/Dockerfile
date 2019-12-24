# Angular cli in a container
#
# docker run -it -v angular_app:/var/www/html -p 4200:4200 inglebard/angular-cli:latest
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_WWW_PATH /var/www/html
ENV ANGULARCLI_VERSION 8.3.21

RUN npm install -g @angular/cli@${ANGULARCLI_VERSION} \
  && rm -rf /tmp/* ~/.npm \
  && npm cache clear --force \
  && mkdir -p /var/www/html

WORKDIR ${ROOT_WWW_PATH}


EXPOSE 4200


CMD [ "sh", "-c", "ng serve --host 0.0.0.0" ]
