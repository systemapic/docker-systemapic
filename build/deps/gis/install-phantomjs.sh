#!/bin/bash
apt-get update -y && apt-get install -y build-essential \
  bison \
  flex \
  g++ \
  gperf \
  libfontconfig1-dev \
  libfreetype6 \
  libicu-dev \
  libjpeg-dev \
  libpng-dev \
  libsqlite3-dev \
  libssl-dev \
  perl \
  ruby \
  || exit 1

cd /opt/ || exit 1
mkdir phantomJS || exit 1
cd phantomJS || exit 1
git clone git://github.com/ariya/phantomjs.git || exit 1
cd phantomjs || exit 1
git checkout 2.0 || exit 1
./build.sh --confirm --jobs 8 || exit 1
ln -s /opt/phantomJS/phantomjs/bin/phantomjs /usr/bin/phantomjs || exit 1
