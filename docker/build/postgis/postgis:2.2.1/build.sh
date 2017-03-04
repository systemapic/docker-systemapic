#!/bin/bash

PGVER=9.3
POSTGISVER=2.2.1
LATEST=yes
IMAGENAME=mapic/postgis:${PGVER}-${POSTGISVER}
LATESTNAME=mapic/postgis:latest
  
function build() {

  echo "Building PostgreSQL version: $PGVER"
  git clone https://github.com/mapic/mapic-postgresql.git
    
  echo "Building $IMAGENAME"
  docker build --build-arg PGVER=${PGVER} -t ${IMAGENAME} . || return 1
  echo "Image ${IMAGENAME} built"

  if test "$LATEST" = "yes"; then
    docker tag ${IMAGENAME} ${LATESTNAME}
    echo "Image tagged as ${LATESTNAME}"
  fi

}

# build
build 

# cleanup
rm -rf mapic-postgresql
