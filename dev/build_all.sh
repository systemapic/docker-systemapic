#!/bin/bash

cd ../build

cd nginx
./build.sh
cd ..

cd mongo
./build.sh
cd ..

cd redis/kue
./build.sh
cd ../..

cd redis/layers
./build.sh
cd ../..

cd redis/stats
./build.sh
cd ../..

cd postgis
./build.sh
cd ..

cd backup/postgis/backup
./build.sh
cd -

cd pile
./build.sh
cd ..

cd wu
./build.sh
cd ..

echo 'All built!'
