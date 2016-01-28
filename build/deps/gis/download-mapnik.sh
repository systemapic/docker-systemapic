#!/bin/bash


die() {
    exit 1
}

test -n "$1"  || { echo "Usage: $0 <destination_dir>" >&2; exit 1; }
SRCDIR=$1

BASEDIR=`dirname ${SRCDIR}`
mkdir -p ${BASEDIR} || die

cd ${BASEDIR}
VER=3.0.9
wget -q https://github.com/mapnik/mapnik/archive/v${VER}.tar.gz -O - |
  tar xzf - || die
mv mapnik-${VER} mapnik || die
#git clone https://github.com/mapnik/mapnik ${SRCDIR} || die
#cd mapnik && git submodule update --init
