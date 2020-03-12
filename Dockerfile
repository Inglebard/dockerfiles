# Vue cli in a container
#
# docker run -it -v react_app:/var/www/html -p 3000:3000 inglebard/reactjs:latest
#
FROM node:lts

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"


ENV ROOT_WWW_PATH /var/www/html
ENV REACT_VERSION 3.4.0

RUN npm install -g create-react-app@${REACT_VERSION} \
  && rm -rf /tmp/* ~/.npm \
  && npm cache clear --force \
  && mkdir -p /var/www/html

WORKDIR ${ROOT_WWW_PATH}


EXPOSE 3000


CMD [ "sh", "-c", "npm start" ]
