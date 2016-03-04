#!/bin/bash


die() {
    exit 1
}

test -n "$1"  || { echo "Usage: $0 <destination_dir>" >&2; exit 1; }
SRCDIR=$1

BASEDIR=`dirname ${SRCDIR}`
mkdir -p ${BASEDIR} || die

cd ${BASEDIR}

# Fixes https://github.com/mapnik/mapnik/issues/2375
REPO=https://github.com/strk/mapnik
BRANCH=systemapic

REFERENCE=
if test -n "$SYSTEMAPIC_SRC_MAPNIK"; then
  REFERENCE="--reference $SYSTEMAPIC_SRC_MAPNIK"
fi

git clone ${REFERENCE} --depth=1 -b ${BRANCH} ${REPO}
cd mapnik || die
git submodule update --init || die
