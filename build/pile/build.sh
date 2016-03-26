#!/bin/bash

function abort() {
        echo $1
        exit 1;
}

function clone_repo() {
        echo "Pulling latest repository... Branch is $BRANCH"
        # clone pile
        # git clone \
        #     --reference ../../modules/pile \
        #     git@github.com:systemapic/pile.git pile ||
        #     abort "Failed to clone systemapic/pile.git... Quitting!"
        # cd pile && git checkout $BRANCH
        git clone git@github.com:systemapic/pile.git
}

BD=`dirname $0`

trap "echo 'Cleaning up'; rm -rf $BD/pile" 0

# clone from tagged version
BRANCH="master" # todo: read from $ARGS
clone_repo

# build
docker build -t systemapic/pile:latest . || abort "Build failed!"
