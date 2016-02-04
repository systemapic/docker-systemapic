#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

function clone_repo() {
	echo "Pulling latest repository... Version is $VERSION"
	# clone pile
	git clone \
    --reference ../../modules/pile \
    git@github.com:systemapic/pile.git pile ||
    abort "Failed to clone systemapic/pile.git... Quitting!"
	# cd pile && git checkout version/$VERSION
}

BD=`dirname $0`

trap "echo 'Cleaning up'; rm -rf $BD/pile" 0

# clone from tagged version
VERSION="1.3.8" # todo: read from $ARGS
clone_repo

# build
docker build -t systemapic/pile:latest . || abort "Build failed!"
