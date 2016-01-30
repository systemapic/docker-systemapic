##
# knutole/dev-pile-server
#
# This creates an image for the pile.js server
#

# Ubuntu 14.04 Trusty Tahyr
# FROM systemapic/gis:node1040
FROM systemapic/gis

# Copy package.json
ADD ./pile/package.json /tmp/package.json
WORKDIR /tmp
RUN export MAKEFLAGS="-j 7"
RUN npm install

# Copy latest pile
ADD ./pile /var/www/pile

# log folder
RUN mkdir /var/www/pile/log

# Inject config
# RUN mkdir /var/www/pile/config 
# ADD ./pile-config.js /var/www/pile/config/pile-config.js

ADD ./start.sh /var/www/pile/start.sh

# Install node_modules
RUN cp /tmp/node_modules /var/www/pile/ -r

# Define working directory.
WORKDIR /var/www/pile

# terminal
ENV TERM xterm 

# Expose port
EXPOSE 3003

# Define default command.
# CMD ["./pile-server.sh"]
CMD ["./start.sh"]
