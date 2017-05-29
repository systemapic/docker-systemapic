#!/bin/bash

# debug mode. usage: command 2>"${PIPE}" 1>"${PIPE}"
if [[ ${MAPIC_DEBUG} = true ]]; then
    PIPE=/dev/stdout
else
    PIPE=/dev/null
fi

# init mapic/mapic submodule
cd $MAPIC_ROOT_FOLDER
git submodule init 2>"${PIPE}" 1>"${PIPE}"
git submodule update --recursive --remote 2>"${PIPE}" 1>"${PIPE}"
git submodule foreach --recursive git checkout master 2>"${PIPE}" 1>"${PIPE}"

# init mapic/mile submodule
cd $MAPIC_ROOT_FOLDER/modules/mile
git submodule init 2>"${PIPE}" 1>"${PIPE}"
git submodule update --recursive --remote 2>"${PIPE}" 1>"${PIPE}"

# init mapic/engine submodule
cd $MAPIC_ROOT_FOLDER/modules/engine
git submodule init 2>"${PIPE}" 1>"${PIPE}"
git submodule update --recursive --remote 2>"${PIPE}" 1>"${PIPE}"

# init mapic/mapic.js submodule
cd $MAPIC_ROOT_FOLDER/modules/mapic.js
git submodule init 2>"${PIPE}"
git submodule update --recursive --remote 2>"${PIPE}" 1>"${PIPE}"

# init mapic/sdk submodule
cd $MAPIC_ROOT_FOLDER/modules/sdk
git submodule init 2>"${PIPE}"
git submodule update --recursive --remote 2>"${PIPE}" 1>"${PIPE}"

# install modules in mapic/mapic (for scripts, etc)
cd $MAPIC_ROOT_FOLDER
npm install 2>"${PIPE}" 1>"${PIPE}"
