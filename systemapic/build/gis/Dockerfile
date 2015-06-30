##
# systemapic/gmn
#


FROM knutole/gdalmapniknode
MAINTAINER @kosjoli

# extras
RUN ls
RUN npm install grunt-cli -g
RUN npm install nodemon -g
RUN npm install forever -g
RUN apt-get update && apt-get install -y nmap pigz

# HPN SSH

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

# phantomjs
RUN apt-get update && apt-get install -y build-essential \ 
	g++ \
	flex \
	bison \
	gperf \
	ruby \
	perl \
  	libsqlite3-dev \
  	libfontconfig1-dev \
  	libicu-dev \
  	libfreetype6 \
  	libssl-dev \
  	libpng-dev \
  	libjpeg-dev

ADD ./install_phantomjs.sh /home/install_phantomjs.sh
RUN sh /home/install_phantomjs.sh
RUN ln -s /home/phantomJS/phantomjs/bin/phantomjs /usr/bin/phantomjs

# install gm
ADD ./install_graphicsmagick.sh /home/install_graphicsmagick.sh
RUN sh /home/install_graphicsmagick.sh

# install extras
RUN apt-get update && apt-get install -y zip

# Cleanup
RUN             apt-get -y autoremove && apt-get -y autoclean