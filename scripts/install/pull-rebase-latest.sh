#!/bin/bash

cd $MAPIC_ROOT_FOLDER || exit 1;

echo "Pulling mapic/mapic"
git pull --rebase
cd modules

echo "Pulling mapic/engine"
cd engine && git pull --rebase && cd ..

echo "Pulling mapic/mile"
cd mile && git pull --rebase && cd ..

echo "Pulling mapic/mapic.js"
cd mapic.js && git pull --rebase && cd ..

echo "Pulling mapic/sdk"
cd sdk && git pull --rebase && cd ..
cd ..
echo "Pulling mapic/config"
cd config && git pull --rebase && cd ..

echo "All pulled!"