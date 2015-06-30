##
# knutole/dev-vile-server
#
# This creates an image for the vile.js server
#

# Ubuntu 14.04 Trusty Tahyr
FROM systemapic/gmn

# Copy package.json
ADD ./vile-grind/package.json /tmp/package.json
WORKDIR /tmp
RUN export MAKEFLAGS="-j 7"
RUN npm install

# Copy latest vile
ADD ./vile-grind /var/www/vile-grind

# log folder
RUN mkdir /var/www/vile-grind/log

# Inject config
RUN mkdir /var/www/vile-grind/config 
ADD ./vile-grind-config.js /var/www/vile-grind/config/vile-grind-config.js

# Install node_modules
RUN cp /tmp/node_modules /var/www/vile-grind/ -r

# Define working directory.
WORKDIR /var/www/vile-grind

ENV TERM xterm

# Expose port
EXPOSE 3004

# Define default command.
CMD ["./vile-grind-server.sh"]