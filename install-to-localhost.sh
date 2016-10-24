#!/bin/bash

# get working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# init dockerize submodules
cd $DIR
git submodule init
git submodule update --recursive --remote
git submodule foreach --recursive git checkout master

# init mile submodules
cd $DIR/modules/mile
git submodule init
git submodule update --recursive --remote

# init engine submodules
cd $DIR/modules/engine
git submodule init
git submodule update --recursive --remote

# init mapic.js submodules
cd $DIR/modules/mapic.js
git submodule init
git submodule update --recursive --remote

# init sdk submodules
cd $DIR/modules/sdk
git submodule init
git submodule update --recursive --remote

