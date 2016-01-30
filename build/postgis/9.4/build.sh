#!/bin/bash

PGVER=9.4
LATEST=yes

while test -n "$1"; do
  opt=$1
  shift
  echo "opt:$opt, args:$@"
  if test "$opt" = "--latest"; then
    LATEST="yes"
  elif test "$opt" = "--no-latest"; then
    LATEST="no"
  else
    PGVER="$opt"
  fi
done

PGVER_SHORT=`echo ${PGVER} | tr -d .`
NAME="systemapic/postgis"
TAG="${PGVER_SHORT}-21"
FULLNAME="${NAME}:${TAG}"
LATESTNAME="${NAME}:latest"

# build
echo "Building $PGVER $FULLNAME"
docker build --build-arg PGVER=${PGVER} -t ${FULLNAME} . || exit 1
echo "Image ${FULLNAME} built"

# tag latest
if test "$LATEST" = "yes"; then
  docker tag -f ${FULLNAME} ${LATESTNAME}
  echo "Image tagged as ${LATESTNAME}"
fi

