FROM ubuntu:18.04
WORKDIR /tmp
RUN apt update && apt install --no-install-recommends -y build-essential
COPY uname_wrapper.c /tmp/

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=unknown

# Define software versions.
ARG VERSION=1.0.0

# Define working directory.
WORKDIR /tmp
