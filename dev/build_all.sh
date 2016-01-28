#!/bin/bash

DIRS="deps/ubuntu deps/gis nginx mongo redis/kue redis/layers redis/stats postgis backup/postgis/backup pile wu"

if test -z "$SYSTEMAPIC_DOMAIN"; then
  DEFAULT_SYSTEMAPIC_DOMAIN=dev.systemapic.com
  echo -n "Enter target domain [${DEFAULT_SYSTEMAPIC_DOMAIN}]: "
  read SYSTEMAPIC_DOMAIN
  if test -z "$SYSTEMAPIC_DOMAIN"; then
    SYSTEMAPIC_DOMAIN=${DEFAULT_SYSTEMAPIC_DOMAIN}
  fi
  export SYSTEMAPIC_DOMAIN
fi

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
echo "Building all dockers for target domain ${SYSTEMAPIC_DOMAIN}"
echo "--------------------------------------------------------------"

cd ../build
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
  echo "Building $dir from $PWD"
  cd $dir && ./build.sh && cd - || {
    echo "Build failed in $dir";
    exit 1;
  }
done

echo 'All built!'
