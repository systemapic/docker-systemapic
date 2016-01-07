#!/bin/bash

cd ../build/deps

cd ubuntu
./build.sh
cd ..

cd gis
./build.sh
cd ..

cd gis:node1040
./build.sh
cd ..

echo 'All done!'