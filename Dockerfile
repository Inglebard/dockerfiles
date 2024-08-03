# A container with borgbackup
FROM alpine:latest

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

RUN apk add borgbackup

CMD [ "sh", "-c", "echo 'Nothing to do'" ]
