##
# knutole/gdalmapniknode
#
# This creates a base image for our node servers
#

# Ubuntu 14.04 Trusty Tahyr
FROM knutole/gdal:mapnik

# Install Node.js
ADD ./install-nodejs.sh /tmp/
RUN sh /tmp/install-nodejs.sh