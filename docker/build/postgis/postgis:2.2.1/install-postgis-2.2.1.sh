#!/bin/bash

POSTGISVER=2.2.1

wget http://download.osgeo.org/postgis/source/postgis-${POSTGISVER}.tar.gz
tar xvzf postgis-${POSTGISVER}.tar.gz 
cd postgis-${POSTGISVER} 
./configure 
make 
make install