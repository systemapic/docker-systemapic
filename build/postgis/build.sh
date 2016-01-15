#!/bin/bash

PGVER=9.3

test -n "$1" && PGVER="$1"

PGVER_SHORT=`echo ${PGVER} | tr -d .`
docker build --build-arg PGVER=${PGVER} -t systemapic/postgis:${PGVER_SHORT}-21 .
