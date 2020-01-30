FROM ubuntu:18.04
MAINTAINER Gig3

# Configure user nobody to match unRAID's settings
RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean

# Volumes
VOLUME ["/config"]

EXPOSE  22
