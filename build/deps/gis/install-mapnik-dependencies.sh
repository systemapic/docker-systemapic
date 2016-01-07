#!/bin/bash

die() {
    exit 1
}

# Install Mapnik dependencies
apt-get update -y
apt-get install -y \ 
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

add-apt-repository ppa:mapnik/nightly-trunk
apt-get update -y
apt-get install -y libboost-dev \
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
    mapnik-input-plugin-gdal \
    mapnik-input-plugin-ogr \
    mapnik-input-plugin-postgis \
    mapnik-input-plugin-sqlite 

cd /tmp/ || die
wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.37.tar.bz2 || die
tar xf harfbuzz-0.9.37.tar.bz2 || die
cd harfbuzz-0.9.37 || die
./configure  || die
make -j7 || die
sudo make install || die
sudo ldconfig || die

rm /tmp/harfbuzz-* -r || die
