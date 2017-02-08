##
# mapic/engine:latest
#

# base image
FROM mapic/gis:latest

# install postgres client only
RUN apt-get install postgresql-client postgis -y

# expose port
EXPOSE 3001

# entrypoint
CMD ./start-server.sh