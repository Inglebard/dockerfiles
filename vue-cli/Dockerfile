# Vue cli in a container
#
# docker run -it -v vue_app:/var/www/html -p 8080:8080 inglebard/cue-cli:latest
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_WWW_PATH /var/www/html
ENV VUECLI_VERSION 4.1.1

RUN npm install -g @vue/cli@${VUECLI_VERSION} \
  && rm -rf /tmp/* ~/.npm \
  && npm cache clear --force \
  && mkdir -p /var/www/html

WORKDIR ${ROOT_WWW_PATH}


EXPOSE 8080


CMD [ "sh", "-c", "npm run serve" ]
