##
# knutole/dev-vile-server
#
# This creates an image for the vile.js server
#

# Ubuntu 14.04 Trusty Tahyr
FROM systemapic/gmn

# Copy package.json
ADD ./vile/package.json /tmp/package.json
WORKDIR /tmp
RUN export MAKEFLAGS="-j 7"
RUN npm install

# Copy latest vile
ADD ./vile /var/www/vile

# log folder
RUN mkdir /var/www/vile/log

# Inject config
RUN mkdir /var/www/vile/config 
ADD ./vile-config.js /var/www/vile/config/vile-config.js

# Install node_modules
RUN cp /tmp/node_modules /var/www/vile/ -r

# Define working directory.
WORKDIR /var/www/vile

# Expose port
EXPOSE 3003

# Define default command.
CMD ["./vile-server.sh"]