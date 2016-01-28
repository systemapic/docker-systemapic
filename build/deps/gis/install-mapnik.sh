#!/bin/bash


die() {
    exit 1
}

test -n "$1"  || { echo "Usage: $0 <source_dir>" >&2; exit 1; }
SRCDIR=$1

cd "${SRCDIR}" || die
./configure BOOST_INCLUDES=/opt/boost/include BOOST_LIBS=/opt/boost/lib || die
make -j7 || die
sudo make install || die

