##
# mapic/engine
#

FROM mapic/gis:latest

# Install GDAL globally
RUN npm install node-pre-gyp -g
RUN npm install gdal -g --build-from-source --shared_gdal --unsafe-perm
RUN npm install mocha -g
RUN npm install npm-check-updates -g 

# upgrade ubuntu
ADD ./upgrade-dist.sh /tmp/upgrade-dist.sh
RUN sh /tmp/upgrade-dist.sh

# Set terminal env
ENV TERM xterm

# Set path for global node_modules
ENV NODE_PATH /usr/local/lib/node_modules

# Expose port
EXPOSE 3001

# Define default command.
CMD ./start-server.sh
