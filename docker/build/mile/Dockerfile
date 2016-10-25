##
# Mile - Mapic Tile Server
#

FROM mapic/gis:latest

# Install mochajs
RUN npm install mocha -g
RUN npm install nodemon -g
RUN npm install topojson -g
RUN npm install npm-check-updates -g

# upgrade ubuntu
ADD ./upgrade-dist.sh /tmp/upgrade-dist.sh
RUN sh /tmp/upgrade-dist.sh

# # add start script
# ADD start.sh /start.sh
# RUN chmod +x /start.sh

# terminal
ENV TERM xterm 

# Expose port
EXPOSE 3003

# Define default command.
CMD ./start-server.sh
