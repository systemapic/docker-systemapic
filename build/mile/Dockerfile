##
# Mile - Mapic Tile Server
#

FROM systemapic/gis:latest

# # Copy package.json
# ADD ./pile/package.json /tmp/package.json
# WORKDIR /tmp
# RUN export MAKEFLAGS="-j 7"
# RUN npm install

# # Copy latest pile
# RUN mkdir -p /systemapic/prod
# ADD pile/ /systemapic/prod

# Install node_modules
# RUN cp /tmp/node_modules /systemapic/prod/pile/ -r

# Install mochajs
RUN npm install mocha -g
RUN npm install nodemon -g
RUN npm install topojson -g

# upgrade ubuntu
ADD ./upgrade-dist.sh /tmp/upgrade-dist.sh
RUN sh /tmp/upgrade-dist.sh

# add start script
ADD start.sh /start.sh
RUN chmod +x /start.sh

# terminal
ENV TERM xterm 

# Expose port
EXPOSE 3003

# Define default command.
CMD /start.sh
