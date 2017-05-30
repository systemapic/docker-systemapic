##
# mapic/engine:latest
#

# base image
FROM mapic/gis:latest

RUN rm /etc/apt/sources.list.d/*
RUN apt-get clean

# install postgis
RUN sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update -y
RUN apt-get install -y postgresql-client postgis libpq-dev python-psycopg2 postgresql 

# install yarn

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update -y 
RUN sudo apt-get install -y yarn


# expose port
EXPOSE 3001

# entrypoint
CMD ./start-server.sh