FROM            ubuntu
MAINTAINER      @kosjoli


# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV             DEBIAN_FRONTEND noninteractive
ENV             INITRD No


# Install updates
RUN             echo "deb http://ppa.launchpad.net/w-rouesnel/openssh-hpn/ubuntu trusty main" > /etc/apt/sources.list.d/w-rouesnel-openssh-hpn.list
RUN             echo "deb-src http://ppa.launchpad.net/w-rouesnel/openssh-hpn/ubuntu trusty main" >> /etc/apt/sources.list.d/w-rouesnel-openssh-hpn.list
RUN             apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0762518E
RUN             apt-get update && apt-get -y upgrade
RUN             apt-get install -y openssh-server

# Setup openssh
RUN             mkdir /var/run/sshd
RUN             echo "HPNDisabled no" >> /etc/ssh/sshd_config
RUN             echo "TcpRcvBufPoll yes" >> /etc/ssh/sshd_config
RUN             echo "HPNBufferSize 8192" >> /etc/ssh/sshd_config
RUN             echo "NoneEnabled yes" >> /etc/ssh/sshd_config
RUN             echo "Port 2222" >> /etc/ssh/sshd_config
RUN             echo "AuthorizedKeysFile	/etc/ssh/authorized_keys" >> /etc/ssh/sshd_config

# Set up keys
ADD ./authorized_keys /etc/ssh/authorized_keys

# Extras
RUN apt-get install -y pigz

# Cleanup
RUN             apt-get -y autoremove && apt-get -y autoclean

EXPOSE          2222

ENV TERM xterm


# Default command
CMD             ["/usr/sbin/sshd", "-D"]