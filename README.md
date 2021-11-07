# Docker image inglebard/tor-relay
tor-relay
[Github](https://github.com/Inglebard/dockerfiles/tree/tor-relay)
[Dockerhub](https://hub.docker.com/r/inglebard/tor-relay)

## Why use this image :

This image was created to run tor-relay with latest version.
This directory is a fork from from https://github.com/jessfraz/dockerfiles

## Technical information :

### Softwares :
* tor

### Ports :
* 9001:9001
* 9030:9030

### Volumes :
You may need to have something like this :
* /etc/localtime:/etc/localtime:ro
* tor-var:/var/lib/tor/.tor
* tor-etc:/etc/tor


## Environment variables

| Name                         | Description                                                                  | Default value |
| ---------------------------- |:----------------------------------------------------------------------------:| -------------:|
| **RELAY_TYPE**               | The type of relay (bridge, middle or exit)                                   | middle        |
| **RELAY_NICKNAME**           | The nickname of your relay                                                   | hacktheplanet |
| **CONTACT_GPG_FINGERPRINT**  | Your GPG ID or fingerprint                                                   | none          |
| **CONTACT_NAME**             | Your name                                                                    | none          |
| **CONTACT_EMAIL**            | Your contact email                                                           | none          |
| **RELAY_BANDWIDTH_RATE**     | Limit how much traffic will be allowed through your relay (must be > 20KB/s) | 100 KBytes    |
| **RELAY_BANDWIDTH_BURST**    | Allow temporary bursts up to a certain amount                                | 200 KBytes    |
| **RELAY_PORT**               | Default port used for incoming Tor connections (ORPort)                      | 9001          |

## How to use this image :

```
docker run -d \
    --restart always \
		-v /etc/localtime:/etc/localtime:ro \
		-v tor-var:/var/lib/tor/.tor \
		-v tor-etc:/etc/tor \
		-p 9001:9001 \
		-p 9030:9030 \
 		--name tor-relay \
 		inglebard/tor-relay -f /etc/tor/torrc.middle
```

## Note :

The default command is `run.sh`.
