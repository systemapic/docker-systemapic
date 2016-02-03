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

# cd /opt/ || exit 1
# mkdir phantomJS || exit 1
# cd phantomJS || exit 1
# git clone git://github.com/ariya/phantomjs.git || exit 1
# cd phantomjs || exit 1
# git checkout 2.1.1 || exit 1
# ./build.sh --confirm --jobs 8 || exit 1
# ln -s /opt/phantomJS/phantomjs/bin/phantomjs /usr/bin/phantomjs || exit 1


cd /opt/
mkdir phantomJS
cd phantomJS
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
mv phantomjs-2.1.1-linux-x86_64 phantomjs
ln -s /opt/phantomJS/phantomjs/bin/phantomjs /usr/bin/phantomjs || exit 1

