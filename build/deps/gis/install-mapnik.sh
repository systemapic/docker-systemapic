#!/bin/bash

test -n "$1"  || { echo "Usage: $0 <source_dir>" >&2; exit 1; }
SRCDIR=$1

cd "${SRCDIR}" || exit 1
#./configure BOOST_INCLUDES=/opt/boost/include BOOST_LIBS=/opt/boost/lib || exit 1
# make JOBS=1 || exit 1
# sudo make install || exit 1

# workaround for Makefile bug, see https://github.com/mapnik/mapnik/issues/3385
python scons/scons.py configure BOOST_INCLUDES=/opt/boost/include BOOST_LIBS=/opt/boost/lib
python scons/scons.py -j7
python scons/scons.py -j7 install
