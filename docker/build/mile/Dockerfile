##
# Mile - Mapic Tile Server
#

# base image
FROM mapic/gis:latest

# install topojson
RUN npm install -g topojson

# install postgres client only
RUN apt-get install postgresql-client postgis -y

# expose port
EXPOSE 3003

# entrypoint
CMD ./start-server.sh
