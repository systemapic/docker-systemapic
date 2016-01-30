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

# Install NodeJS 10.40
ADD ./install-nodejs1040.sh /tmp/
RUN sh /tmp/install-nodejs1040.sh

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
ADD ./install-mapnik-dependencies.sh /tmp/
RUN sh /tmp/install-mapnik-dependencies.sh

RUN apt-get install -y git 

# Download Mapnik
ADD ./download-mapnik.sh /tmp/
RUN sh /tmp/download-mapnik.sh /tmp/mapnik

# Install Mapnik
ADD ./install-mapnik.sh /tmp/
RUN sh /tmp/install-mapnik.sh /tmp/mapnik

# Remove mapnik sources
RUN rm -rf /tmp/mapnik

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
RUN apt-get update && apt-get install -y nmap pigz zip mlocate redis-tools fish

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Externally accessible data is by default put in /data
WORKDIR /data
VOLUME ["/data"]

# Execute the gdal utilities as root
USER root

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats
