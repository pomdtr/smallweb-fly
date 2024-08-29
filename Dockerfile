FROM denoland/deno:1.46.1

RUN apt-get update \
    && apt-get install -y curl rclone \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

ARG SMALLWEB_VERSION=0.13.0-rc.1
RUN curl -fsSL 'https://install.smallweb.run?v=${SMALLWEB_VERSION}&target_dir=/usr/local/bin' | sh

RUN useradd -m -s /bin/bash fly
RUN chown fly:fly /home/fly

WORKDIR /home/fly
USER fly

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
