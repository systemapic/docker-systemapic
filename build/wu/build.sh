#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

function clone_repo() {
	echo "Pulling latest repository... Version is $VERSION"
	# clone wu
	git clone git@github.com:systemapic/wu.git wu || abort "Failed to clone systemapic/wu.git... Quitting!"
	cd wu && git checkout version/$VERSION

	# clone systemapic.js (aka public)
	rm -rf public
	git clone git@github.com:systemapic/systemapic.js.git public || abort "Failed to clone systemapic/systemapic.js.git... Quitting!"
	# cd public && git checkout version/$VERSION # todo
	cd ..
}

BD=`dirname $0`

trap "echo 'Cleaning up'; rm -rf $BD/wu" 0



# clone from tagged version
VERSION="1.3.8" # todo: read from $ARGS
clone_repo

# docker doesn't allow ADDing paths above Dockerfile dirname
# NOTE: it is intentional to omit the .git dir
# mkdir wu && cp -r ../../modules/wu/* wu || exit 1  # todo: clone

# build
docker build -t systemapic/wu:latest . || abort "Build failed!"