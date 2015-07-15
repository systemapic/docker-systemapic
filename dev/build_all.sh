#!/bin/bash

cd ../build

cd nginx
./build.sh
cd ..

cd mongo
./build.sh
cd ..

cd rkue
./build.sh
cd ..

cd rtoken
./build.sh
cd ..

cd vile
./build.sh
cd ..

cd wu
./build.sh
cd ..
