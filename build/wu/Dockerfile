##
# knutole/dev-wu-server
#
# This creates an image for the wu.js server
#

FROM systemapic/gis

# Install GDAL globally
RUN npm install node-pre-gyp -g
RUN npm install gdal -g --build-from-source --shared_gdal --unsafe-perm
RUN npm install mocha -g
RUN apt-get update -y && apt-get install -y sysstat

# Copy package.json
ADD wu/package.json /tmp/package.json
WORKDIR /tmp
RUN export MAKEFLAGS="-j 7"
RUN npm install

# Copy latest wu
RUN mkdir -p /systemapic/prod
ADD wu/ /systemapic/prod

# Install node_modules
RUN mv /tmp/node_modules /systemapic/prod/node_modules

# Add start script
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Set terminal env
ENV TERM xterm

# Set path for global node_modules
ENV NODE_PATH /usr/local/lib/node_modules

# Expose port
EXPOSE 3001

# Define default command.
CMD /start.sh