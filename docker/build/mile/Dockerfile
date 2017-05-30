##
# Mile - Mapic Tile Server
#

# base image
FROM mapic/engine:latest

# install topojson
RUN npm install -g topojson

# expose port
EXPOSE 3003

# entrypoint
CMD ./start-server.sh
