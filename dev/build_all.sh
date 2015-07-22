#!/bin/bash

cd ../build

cd nginx
./build.sh
cd ..

cd mongo
./build.sh
cd ..

cd redis
./build.sh
cd ..

cd postgis
./build.sh
cd ..

cd pile
./build.sh
cd ..

cd wu
./build.sh
cd ..
