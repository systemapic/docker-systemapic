#!/bin/bash

PGVER=9.3

test -n "$1" && PGVER="$1"

PGVER_SHORT=`echo ${PGVER} | tr -d .`
NAME="systemapic/postgis"
TAG="${PGVER_SHORT}-21"
FULLNAME="${NAME}:${TAG}"
docker build --build-arg PGVER=${PGVER} -t ${FULLNAME} . || exit 1

echo "Image ${FULLNAME} built"


