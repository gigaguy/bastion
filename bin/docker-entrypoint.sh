#!/bin/bash

# Don't allow the setup to proceed unless there's an SSH password defined
[ -z "${SSH_PASSWORD}" ] && \
    echo "[ERROR] Please define a \$SSH_PASSWORD before you continue." && exit 1

# Change the SSH user's password to the environment variable
echo "bastion:${SSH_PASSWORD}" | chpasswd

# Change bastion's home directory if specified
[ -n "${SSH_HOME_DIR}" ] && \
    usermod -d $SSH_HOME_DIR bastion

exec "$@"
