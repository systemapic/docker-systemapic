#!/bin/bash

function build() {
  
  git clone https://github.com/mapic/mapic-postgresql.git

  # PGVER_SHORT=`echo ${PGVER} | tr -d .`
  NAME="mapic/postgis"
  # TAG="${PGVER_SHORT}-21"
  TAG="93-21"
  # TAG="${PGVER_SHORT}-22"
  # FULLNAME="${NAME}:${TAG}"
  # FULLNAME="${NAME}:${TAG}"
  FULLNAME="mapic/postgis:93-21"
  # LATESTNAME="${NAME}:latest"
  LATESTNAME="mapis/postgis:latest"

  echo "Building 9.3 mapic/postgis:93-21"
  # echo "Building $PGVER $FULLNAME"
  # docker build --build-arg PGVER=${PGVER} -t ${FULLNAME} . || return 1
  # docker build --build-arg PGVER=9.3 -t mapic/postgis:93-21 . || return 1
  docker build -t mapic/postgis:93-21 . || return 1

  # echo "Image ${FULLNAME} built"
  echo "Image mapic/postgis:93-21 built succesfully!"

  # tag image latest
  # docker tag mapic/postgis:93-21 mapic/postgis:latest

  # if test "$LATEST" = "yes"; then
  #   docker tag ${FULLNAME} ${LATESTNAME}
  #   echo "Image tagged as ${LATESTNAME}"
  # fi

  # cleanup
  rm -rf mapic-postgresql
}

PGVER=9.3
LATEST=yes

# while test -n "$1"; do
#   opt=$1
#   shift
#   echo "opt:$opt, args:$@"
#   if test "$opt" = "--latest"; then
#     LATEST="yes"
#   elif test "$opt" = "--no-latest"; then
#     LATEST="no"
#   else
#     PGVER="$opt"
#   fi
# done

# prompt version if not specified like `./build.sh 9.3`
# while test -z "$PGVER"; do
#   read -e -p "Enter PostgreSQL version to build: " PGVER
# done

# echo "Building PostgreSQL version: $PGVER"
echo "Building PostgreSQL version: 9.3"

  build || exit 1

# # only match supported versions
# if [ "$PGVER" = "9.4" ] || [ "$PGVER" = "9.3" ] ||
#    [ "$PGVER" = "9.5" ]
# then
#   build || exit 1
# else
#   echo "Build support only for 9.3 to 9.5. Quitting!"
#   exit 1
# fi

