##
# knutole/dev-wu-server
#
# This creates an image for the wu.js server
#

FROM systemapic/gis

# Install GDAL globally
RUN npm install node-pre-gyp -g
RUN npm install gdal -g --build-from-source --shared_gdal --unsafe-perm

# Copy package.json
ADD ./wu/package.json /tmp/package.json
WORKDIR /tmp
RUN export MAKEFLAGS="-j 7"
RUN npm install

# Set path for global node_modules
ENV NODE_PATH /usr/local/lib/node_modules

# Copy latest wu
ADD ./wu /var/www/wu

# Inject config
ADD ./server-config.js /var/www/wu/config/server-config.js

# log folder
RUN mkdir /var/www/wu/log

# Install node_modules
RUN cp /tmp/node_modules /var/www/wu/ -r

# Install extras
RUN apt-get update
RUN apt-get install -y sysstat
RUN npm install mocha -g

# Set terminal env
ENV TERM xterm

# set prod mode
ENV SYSTEMAPIC_PRODMODE true

# Define working directory.
WORKDIR /var/www/wu

# Expose port
EXPOSE 3001
