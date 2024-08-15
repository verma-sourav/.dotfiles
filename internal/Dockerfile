# Dockerfile with a minimal Linux install to test the dotfiles installer on
FROM ubuntu:24.04
ARG TESTUSER=test
RUN <<EOT
    set -eux
    apt update -y
    apt install -y bash git curl sudo

    # Create a non-root user with sudo access. It uses the credential 'password' for sudo
    useradd --create-home --shell /bin/bash "$TESTUSER"
    echo "$TESTUSER:password" | chpasswd
    usermod -aG sudo "$TESTUSER"
EOT

ENV TERM=xterm-256color
WORKDIR /home/${TESTUSER}
USER ${TESTUSER}
