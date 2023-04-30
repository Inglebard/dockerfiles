# Run stable-diffusion-ui in a container
#
# docker run -t -i \
# -v /dev/shm:/dev/shm \
# -p 9000:9000 \
# inglebard/stable-diffusion-ui
#
FROM debian:bullseye

LABEL maintainer "David 'Inglebard' RICQ <davidricq87@orange.fr>"

RUN apt-get update && apt-get install -y \
	ca-certificates \
	curl \
	python3 \
	unzip \
	libgl1 \
	libglib2.0-0 \
	bzip2 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& mkdir /opt/easy-diffusion/ \
	&& chowm -R user:user /opt/easy-diffusion/



ENV HOME /home/user
WORKDIR $HOME
USER user

ENV LANG C.UTF-8

#https://github.com/cmdr2/stable-diffusion-ui/releases
ENV STABLE_DIFFUSION_UI_VERSION v2.5.24

RUN cd /tmp \
	&& curl -sSOL "https://github.com/cmdr2/stable-diffusion-ui/releases/download/${STABLE_DIFFUSION_UI_VERSION}/Easy-Diffusion-Linux.zip" \
	&& unzip /tmp/Easy-Diffusion-Linux.zip -d /opt \
	&& rm /tmp/Easy-Diffusion-Linux.zip \
	&& cd /opt/easy-diffusion/ \
	&& sed -i 's/exec .\/scripts\/on_sd_start.sh/#exec .\/scripts\/on_sd_start.sh/g' /opt/easy-diffusion/scripts/on_env_start.sh \
	&& bash start.sh \
	&& sed -i 's/#exec .\/scripts\/on_sd_start.sh/exec .\/scripts\/on_sd_start.sh/g' /opt/easy-diffusion/scripts/on_env_start.sh \
	&& cp /opt/easy-diffusion/scripts/on_sd_start.sh /opt/easy-diffusion/scripts/on_sd_start.sh.ori \
	&& cp /opt/easy-diffusion/scripts/on_env_start.sh /opt/easy-diffusion/scripts/on_env_start.sh.ori \
	&& sed -i '87,91d' /opt/easy-diffusion/scripts/on_sd_start.sh \
	&& sed -i '11,43d' /opt/easy-diffusion/scripts/on_env_start.sh \
	&& bash start.sh \
	&& mv /opt/easy-diffusion/scripts/on_sd_start.sh.ori /opt/easy-diffusion/scripts/on_sd_start.sh \
	&& mv /opt/easy-diffusion/scripts/on_env_start.sh.ori /opt/easy-diffusion/scripts/on_env_start.sh \
	&& echo '{"render_devices": "auto", "update_branch": "main", "ui": {"open_browser_on_start": false}, "net": {"listen_port": 9000,"listen_to_network": true}}' > /opt/easy-diffusion/scripts/config.json \
	&& chown -R user:user /opt/easy-diffusion/ \
	&& rm -r /home/user/.cache /home/user/.conda


#EXPOSE 9000

ENTRYPOINT bash -c '/opt/easy-diffusion/start.sh'