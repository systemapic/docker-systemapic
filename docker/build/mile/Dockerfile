##
# Mile - Mapic Tile Server
#

# base image
FROM mapic/gis:latest

# install topojson
RUN yarn global add topojson

# expose port
EXPOSE 3003

# entrypoint
CMD ./start-server.sh
