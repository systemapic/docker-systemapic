# creates an image with ALL gis dependencies installed (gdal, node, mapnik, etc)
# replaces gdalmapniknode, gis (but not gis:node1040)

FROM ubuntu:trusty

MAINTAINER Knut Ole Sjøli <knutole@systemapic.com>

# Ensure the package repository is up to date
RUN apt-get update -y

# Install basic dependencies
RUN apt-get install -y \
    software-properties-common \
    python-software-properties \
    build-essential \
    wget \
    subversion \
    openjdk-7-jdk \
    mysql-client \
    mysql-server \
    unzip

# Install Postgresql
ADD ./install-postgres.sh /tmp/
RUN sh /tmp/install-postgres.sh

# Install Postgis
ADD ./install-postgis.sh /tmp/
RUN sh /tmp/install-postgis.sh

# Get the GDAL source
ADD ./gdal-checkout.txt /tmp/gdal-checkout.txt
ADD ./get-gdal.sh /tmp/
RUN sh /tmp/get-gdal.sh

# Install the GDAL source dependencies
ADD ./install-gdal-deps.sh /tmp/
RUN sh /tmp/install-gdal-deps.sh

# Install GDAL itself
ADD ./install-gdal.sh /tmp/
RUN sh /tmp/install-gdal.sh

# Install Mapnik dependencies
RUN apt-get install software-properties-common python-software-properties -y
# RUN add-apt-repository ppa:mapnik/boost && apt-get update
RUN apt-get install -y \ 
    libboost-dev libboost-filesystem-dev libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev libboost-system-dev libboost-thread-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev \
    libboost-system-dev libboost-thread-dev libtiff5 libtiff5-dev \
    libicu-dev \
    python-dev libxml2 libxml2-dev \
    libfreetype6 libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libproj-dev \
    libtiff-dev \
    libcairo2 libcairo2-dev python-cairo python-cairo-dev \
    libcairomm-1.0-1 libcairomm-1.0-dev \
    ttf-unifont ttf-dejavu ttf-dejavu-core ttf-dejavu-extra \
    git build-essential python-nose \
    libgdal1-dev libsqlite3-dev fish htop nano || die

# Install Mapnik dependencies
ADD ./install-mapnik-dependencies.sh /tmp/
RUN sh /tmp/install-mapnik-dependencies.sh

# install latest boost
ADD ./install-boost.sh /tmp/
RUN sh /tmp/install-boost.sh

# Install Mapnik
ADD ./install-mapnik.sh /tmp/
RUN sh /tmp/install-mapnik.sh

# Install Node.js
ADD ./install-nodejs.latest.sh /tmp/
RUN sh /tmp/install-nodejs.latest.sh

# Install PhanomJS
ADD ./install-phantomjs.sh /tmp/install-phantomjs.sh
RUN sh /tmp/install-phantomjs.sh

# Install Graphics Magick
ADD ./install-graphicsmagick.sh /tmp/install-graphicsmagick.sh
RUN sh /tmp/install-graphicsmagick.sh

# Run the tests
ADD ./test-gdal.sh /tmp/
RUN sh /tmp/test-gdal.sh

# Install extras
RUN npm install grunt-cli -g
RUN npm install nodemon -g
RUN npm install forever -g
RUN apt-get update && apt-get install -y nmap pigz zip


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

# # phantomjs
# RUN apt-get update && apt-get install -y build-essential \ 
#     g++ \
#     flex \
#     bison \
#     gperf \
#     ruby \
#     perl \
#     libsqlite3-dev \
#     libfontconfig1-dev \
#     libicu-dev \
#     libfreetype6 \
#     libssl-dev \
#     libpng-dev \
#     libjpeg-dev

# ADD ./install_phantomjs.sh /home/install_phantomjs.sh
# RUN sh /home/install_phantomjs.sh
# RUN ln -s /home/phantomJS/phantomjs/bin/phantomjs /usr/bin/phantomjs

# install gm
# ADD ./install_graphicsmagick.sh /home/install_graphicsmagick.sh
# RUN sh /home/install_graphicsmagick.sh

# install extras
RUN apt-get update && apt-get install -y zip

# Cleanup
RUN apt-get -y autoremove && apt-get -y autoclean

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Externally accessible data is by default put in /data
WORKDIR /data
VOLUME ["/data"]

# Execute the gdal utilities as root
USER root

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
