#!/bin/bash

DIRS="nginx mongo redis/kue redis/layers redis/stats postgis backup/postgis/backup pile wu"

cd ../build
for dir in $DIRS; do
  echo "Building $dir from $PWD"
  cd $dir && ./build.sh && cd - || exit 1
done

echo 'All built!'
