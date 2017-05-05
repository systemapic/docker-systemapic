##
# mapic/engine:latest
#

# base image
FROM mapic/gis:latest

# install postgis
RUN apt-get update -y
RUN apt-get install -y postgresql-client postgis libpq-dev python-psycopg2 postgresql 

# expose port
EXPOSE 3001

# entrypoint
CMD ./start-server.sh