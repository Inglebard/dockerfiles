# Vue cli in a container
#
# docker run -it -v vue_app:/var/www/html -p 8080:8080 inglebard/vue-cli:latest
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_WWW_PATH /var/www/html
ENV VUECLI_VERSION 4.5.3

RUN npm install -g @vue/cli@${VUECLI_VERSION} \
  && rm -rf /tmp/* ~/.npm \
  && npm cache clear --force \
  && mkdir -p ${ROOT_WWW_PATH} \
  && chown node:node -R ${ROOT_WWW_PATH}

WORKDIR ${ROOT_WWW_PATH}

USER node

EXPOSE 8080


CMD [ "sh", "-c", "npm run serve" ]
