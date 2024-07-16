FROM denoland/deno:1.45.2

ARG SMALLWEB_VERSION=0.11.0-rc.1
ARG USERNAME="fly"

RUN apt-get update \
    && apt-get install -y sudo curl vim openssh-server \
    && cp /etc/ssh/sshd_config /etc/ssh/sshd_config-original \
    && sed -i 's/^#\s*Port.*/Port 2222/' /etc/ssh/sshd_config \
    && sed -i 's/^#\s*PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && mkdir /var/run/sshd \
    && chmod 755 /var/run/sshd \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# install smallweb
RUN curl -fsSL https://install.smallweb.run?v=${SMALLWEB_VERSION} | sh
RUN mv /root/.local/bin/smallweb /usr/local/bin/smallweb

RUN useradd -m -s /bin/bash ${USERNAME}
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}

RUN echo "%${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/${USERNAME}
USER ${USERNAME}

COPY --chown=${USERNAME}:${USERNAME} entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["smallweb", "up", "--host=0.0.0.0"]
