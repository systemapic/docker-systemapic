## Base images

These are the images all other images are based on, `mapic/gis` and `mapic/ubuntu`.


### `mapic/ubuntu`
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
 - NodeJS 7.4

### `mapic/gis` 
Based on offical `mapic/ubuntu` with some extra tools:
 - Mapnik
 - GDAL
 - PhantomJS
 - GraphichMagick

Used as base image for `mapic/engine` and `mapic/mile`.