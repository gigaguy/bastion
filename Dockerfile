FROM ubuntu:18.04

MAINTAINER Gig3
LABEL maintainer=Gig3

RUN apt-get update && apt-get install -y openssh-server vim

ARG HOME=/var/lib/bastion

ARG USER=bastion
ARG GROUP=bastion
ARG UID=4096
ARG GID=4096

ENV HOST_KEYS_PATH_PREFIX="/usr"
ENV HOST_KEYS_PATH="${HOST_KEYS_PATH_PREFIX}/etc/ssh"

COPY bastion /usr/sbin/bastion

RUN mkdir -p /var/run/sshd \
  && mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && touch /root/.ssh/authorized_keys

EXPOSE 22/tcp

VOLUME ${HOST_KEYS_PATH}

ENTRYPOINT ["bastion"]
