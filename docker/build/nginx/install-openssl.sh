#!/bin/bash
# install open-ssl

OSSLVER=1.1.0d # TODO: figure out how to identify "latest"

die() {
    exit 1
}

cd /tmp/ || die
wget https://www.openssl.org/source/openssl-${OSSLVER}.tar.gz
tar xvf  openssl-${OSSLVER}.tar.gz || die
mv openssl-${OSSLVER} openssl
cd openssl || die
./config --openssldir=/usr/local/openssl || die
make || die
make install || die
sudo ln -sf /usr/local/ssl/bin/openssl /usr/bin/openssl || die

sudo apt-get update -y || die
sudo apt-get install -y libpcre3-dev libpcre++-dev || die
