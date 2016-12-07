#!/bin/bash

echo "Preparing to create storage containers..."
docker run -it --rm --name create-containers -v "$PWD":/usr/src/app -w /usr/src/app node:4 node .storage-script-helper.js

echo "Creating storage containers..."
sh createcontainers.tmp.sh

# cleanup
echo "Storage containers created!"
rm createcontainers.tmp.sh
