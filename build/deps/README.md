## Base images

These are the images all other images are based on, `systemapic/gis` and `systemapic/ubnutu`.

### `gis` 
Contains:
 - Mapnik
 - GDAL
 - NodeJS
 - PhantomJS
 - PostGIS/Postgresql
 - GraphichMagick

Used as base image for `systemapic/wu` and `systemapic/pile`.


### `ubuntu`
Based on offical `ubuntu:trusty` with some extra tools:
 - fish 
 - wget 
 - htop 
 - curl 
 - unzip 
 - bmon 
 - nmon 
 - nmap 
 - pigz 
 - build-essential