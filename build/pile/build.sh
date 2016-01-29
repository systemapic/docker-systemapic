#!/bin/bash

trap "echo 'Cleaning up pile'; rm -rf `dirname $0`/pile" 0

# docker doesn't allow ADDing paths above Dockerfile dirname
# NOTE: it is intentional to omit the .git dir
mkdir pile && cp -r ../../modules/pile/* pile || exit 1

# build
docker build -t systemapic/pile .
# docker build -t debug/pile:node1040 .

