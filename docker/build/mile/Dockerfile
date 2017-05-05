##
# Mile - Mapic Tile Server
#

# base image
FROM mapic/gis:latest

# install topojson
RUN npm install -g topojson

# install postgis
RUN apt-get update -y
RUN apt-get install -y postgresql-client postgis libpq-dev python-psycopg2 postgresql 

# expose port
EXPOSE 3003

# entrypoint
CMD ./start-server.sh
