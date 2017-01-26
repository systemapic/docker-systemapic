#!/bin/bash

# test latest docker version, TODO!
DOCKER_VERSION=${docker --version}

DIRS="base-images/ubuntu base-images/gis nginx mongo postgis mile engine"

test -n "$1" && MAPIC_DOMAIN="$1"

if test -z "$MAPIC_DOMAIN"; then
  DEFAULT_MAPIC_DOMAIN=localhost
  echo "No MAPIC_DOMAIN env variable set and no parameter given,"
  echo -n "enter target domain here [${DEFAULT_MAPIC_DOMAIN}]: "
  read MAPIC_DOMAIN
  if test -z "$MAPIC_DOMAIN"; then
    MAPIC_DOMAIN=${DEFAULT_MAPIC_DOMAIN}
  fi
fi
export MAPIC_DOMAIN

SKIP=
ONLY=

while getopts "v:" opt; do
  case $opt in
    v) SKIP=$OPTARG; echo "SKIP:$SKIP";;
  esac
done
shift $((OPTIND-1))
if test -n "$1"; then
  echo "ONLY:$ONLY"
  ONLY=$1
fi

echo "--------------------------------------------------------------"
echo "Building all dockers for target domain ${MAPIC_DOMAIN}"
echo "--------------------------------------------------------------"

cd `dirname $0`
for dir in $DIRS; do
  if test -n "$ONLY"; then
     #echo "Checking against $ONLY"
     if echo $dir | grep -q -- "$ONLY"; then
      :
     else
      echo "Skipping $dir (does not match pattern)"
      continue
     fi
  fi
  if test -n "$SKIP" && echo $dir | grep -q -- "$SKIP"; then
    echo "Skipping $dir (in skip list)"
    continue
  fi
  echo "Building $dir from $PWD/$dir"
  cd $dir && ./build.sh && cd - || {
    echo "Build failed in $dir";
    exit 1;
  }
done

echo 'All built!'
