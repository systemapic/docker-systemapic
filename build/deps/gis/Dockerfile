##
# geodata/gdal
#
# This creates an Ubuntu derived base image that installs the latest GDAL
# subversion checkout compiled with a broad range of drivers.  The build
# process closely follows that defined in
# <https://github.com/OSGeo/gdal/blob/trunk/.travis.yml>
#
# Forked from: https://github.com/geo-data/gdal-docker

# Ubuntu 14.04 Trusty Tahyr
FROM ubuntu:trusty

MAINTAINER Knut Ole Sjøli <@kosjoli>

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

RUN apt-get install -y curl

# Install Node.js 10.40
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D
ENV NODE_VERSION 0.10.40
ENV NPM_VERSION 2.11.3
RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
    && gpg --verify SHASUMS256.txt.asc \
    && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
    && npm install -g npm@"$NPM_VERSION" \
    && npm cache clear

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

# Run GDAL tests
ADD ./test-gdal.sh /tmp/
RUN sh /tmp/test-gdal.sh

# Install Mapnik dependencies
RUN apt-get install -y \ 
    software-properties-common python-software-properties \
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
    libgdal1-dev libsqlite3-dev fish htop nano curl wget 

# Install Mapnik dependencies
ADD ./install-mapnik-dependencies.sh /tmp/
RUN sh /tmp/install-mapnik-dependencies.sh

# Install latest boost
# ADD ./install-boost.sh /tmp/
# RUN sh /tmp/install-boost.sh
RUN add-apt-repository ppa:mapnik/nightly-trunk
RUN apt-get update -y
RUN apt-get install -y libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-python-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libtiff5 \
    libtiff5-dev \
    libicu-dev \
    python-dev \
    libxml2 \
    libxml2-dev \
    libfreetype6 \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libproj-dev \
    libtiff-dev \
    libcairo2 \
    libcairo2-dev \
    python-cairo \
    python-cairo-dev \
    libcairomm-1.0-1 \
    libcairomm-1.0-dev \
    ttf-unifont \
    ttf-dejavu \
    ttf-dejavu-core \
    ttf-dejavu-extra \
    python-nose \
    libgdal1-dev \
    libsqlite3-dev \
    libmapnik \
    libmapnik-dev \
    mapnik-utils \
    # python-mapnik \
    mapnik-input-plugin-gdal \
    mapnik-input-plugin-ogr \
    mapnik-input-plugin-postgis \
    mapnik-input-plugin-sqlite 
    # mapnik-input-plugin-osm

# Install Mapnik
ADD ./install-mapnik.sh /tmp/
RUN sh /tmp/install-mapnik.sh

# Install PhantomJS
ADD ./install-phantomjs.sh /tmp/install-phantomjs.sh
RUN sh /tmp/install-phantomjs.sh

# Install Graphics Magick
ADD ./install-graphicsmagick.sh /tmp/install-graphicsmagick.sh
RUN sh /tmp/install-graphicsmagick.sh

# Install extras
RUN npm install grunt-cli -g
RUN npm install nodemon -g
RUN npm install forever -g
RUN apt-get update && apt-get install -y nmap pigz zip mlocate redis-tools

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Externally accessible data is by default put in /data
WORKDIR /data
VOLUME ["/data"]

# Execute the gdal utilities as root
USER root

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
