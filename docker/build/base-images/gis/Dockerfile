##
# mapic/gis:latest
#

# base image
FROM mapic/ubuntu:latest

# maintainer
MAINTAINER Knut Ole Sjøli <@kosjoli>

# install java
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update -y
RUN apt-get install -y openjdk-8-jdk 

# install mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client

# install gdal
ADD gdal /usr/local/src/gdal-docker/
RUN make -C /usr/local/src/gdal-docker install clean 
RUN yarn global add gdal --build-from-source --shared_gdal --unsafe-perm
RUN gdalinfo --version && gdalinfo --formats && ogrinfo --formats

# install graphics magick
ADD ./install-graphicsmagick.sh /tmp/install-graphicsmagick.sh
RUN sh /tmp/install-graphicsmagick.sh

# install phantom-js
ADD ./install-phantomjs.sh /tmp/install-phantomjs.sh
RUN sh /tmp/install-phantomjs.sh

# install mapnik deps
ADD ./install-mapnik-dependencies.sh /tmp/
RUN sh /tmp/install-mapnik-dependencies.sh

# download mapnik
ADD ./download-mapnik.sh /tmp/
RUN sh /tmp/download-mapnik.sh /tmp/mapnik

# install mapnik
ADD ./install-mapnik.sh /tmp/
RUN sh /tmp/install-mapnik.sh /tmp/mapnik

# remove mapnik tmp
RUN rm -rf /tmp/mapnik

# workdir
WORKDIR /data

# volume
VOLUME ["/data"]