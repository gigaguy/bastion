FROM ubuntu:18.04
MAINTAINER Gig3

RUN apt-get update && apt-get install -y openssh-server vim
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

COPY bastion /usr/sbin/bastion

RUN mkdir -p /var/run/sshd \
  && mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && touch /root/.ssh/authorized_keys

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
