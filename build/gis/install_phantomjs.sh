#!/bin/bash
cd /home
mkdir phantomJS
cd phantomJS
git clone git://github.com/ariya/phantomjs.git
cd phantomjs
git checkout 1.9
./build.sh --confirm --jobs 8