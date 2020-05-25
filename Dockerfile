FROM alpine:latest

MAINTAINER Gig3 

ENV AUTHORIZED_KEYS=

# Install required packages
RUN apk add --no-cache openssh mysql-client bash \
	 wget curl vim shadow coreutils screen \
	 gawk git fail2ban tmux lastpass-cli less more


# Configure the SSH server
RUN sed -i 's/\#PubkeyAuthentication\ yes/PubkeyAuthentication\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#PasswordAuthentication\ yes/PasswordAuthentication\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#PermitEmptyPasswords\ no/PermitEmptyPasswords\ no/' /etc/ssh/sshd_config && \
    sed -i 's/\#X11Forwarding\ no/X11Forwarding\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#AllowTcpForwarding\ yes/AllowTcpForwarding\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#AllowAgentForwarding\ yes/AllowAgentForwarding\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#UseDNS\ no/UseDNS\ no/' /etc/ssh/sshd_config && \
    sed -i 's/\#LogLevel\ INFO/LogLevel\ VERBOSE /' /etc/ssh/sshd_config && \
    ssh-keygen -A

# Add a "bastion" user with a default password of "bastion"
RUN adduser -s /bin/bash -S bastion --uid 1024 -G users && \
    echo "bastion:bastion" | chpasswd && \
    mkdir -p /home/bastion/.ssh

# Possible fix to alow SSH logs to stdout
RUN chmod o+w /dev/stdout

# Set a motd
ADD etc/motd.txt /etc/motd

# Expose SSH
EXPOSE 22

# Define our entrypoint
ADD bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["bash", "/usr/local/bin/docker-entrypoint.sh"]



# Start the server
CMD ["/usr/sbin/sshd", "-D", "-e"]
