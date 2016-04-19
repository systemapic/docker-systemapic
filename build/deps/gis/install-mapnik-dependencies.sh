#!/bin/bash

die() {
    exit 1
}

# latest boost
sudo add-apt-repository ppa:boost-latest/ppa

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
    libsqlite3-dev

cd /tmp/ || die
wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.37.tar.bz2 || die
tar xf harfbuzz-0.9.37.tar.bz2 || die
cd harfbuzz-0.9.37 || die
./configure  || die
make -j7 || die
sudo make install || die
sudo ldconfig || die

rm /tmp/harfbuzz-* -r || die

# install libboost 1.60
cd /tmp/
wget http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz
tar xzf boost_1_60_0.tar.gz
cd boost_1_60_0/
./bootstrap.sh --prefix=/opt/boost
./b2 install -j8 --prefix=/opt/boost
