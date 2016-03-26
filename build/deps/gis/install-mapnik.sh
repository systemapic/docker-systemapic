#!/bin/bash

test -n "$1"  || { echo "Usage: $0 <source_dir>" >&2; exit 1; }
SRCDIR=$1

cd "${SRCDIR}" || exit 1
./configure BOOST_INCLUDES=/opt/boost/include BOOST_LIBS=/opt/boost/lib || exit 1
make JOBS=8 || exit 1
sudo make install || exit 1
