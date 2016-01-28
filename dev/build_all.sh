#!/bin/bash

DIRS="deps/ubuntu deps/gis nginx mongo redis/kue redis/layers redis/stats postgis backup/postgis/backup pile wu"

if test -z "$SYSTEMAPIC_DOMAIN"; then
  DEFAULT_SYSTEMAPIC_DOMAIN=dev.systemapic.com
  echo -n "Enter target domain [${DEFAULT_SYSTEMAPIC_DOMAIN}]:"
  read SYSTEMAPIC_DOMAIN
  if test -z "$SYSTEMAPIC_DOMAIN"; then
    SYSTEMAPIC_DOMAIN=${DEFAULT_SYSTEMAPIC_DOMAIN}
  fi
  export SYSTEMAPIC_DOMAIN
fi

echo "--------------------------------------------------------------"
echo "Building all dockers for target domain ${SYSTEMAPIC_DOMAIN}"
echo "--------------------------------------------------------------"

cd ../build
for dir in $DIRS; do
  echo "Building $dir from $PWD"
  cd $dir && ./build.sh && cd - || exit 1
done

echo 'All built!'
