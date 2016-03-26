#!/bin/bash


die() {
    exit 1
}

test -n "$1"  || { echo "Usage: $0 <destination_dir>" >&2; exit 1; }
SRCDIR=$1

BASEDIR=`dirname ${SRCDIR}`
mkdir -p ${BASEDIR} || die
cd ${BASEDIR}

# repo/branch 
# REPO=https://github.com/systemapic/mapnik
REPO=https://github.com/knutole/mapnik
BRANCH=systemapic
# BRANCH=master  

# reference local copy if available
REFERENCE=
if test -n "$SYSTEMAPIC_SRC_MAPNIK"; then
  REFERENCE="--reference $SYSTEMAPIC_SRC_MAPNIK"
fi

# download mapnik
git clone ${REFERENCE} --verbose --depth=1 --recursive -b ${BRANCH} ${REPO}
