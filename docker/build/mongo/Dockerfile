FROM mongo:latest
MAINTAINER <knutole@mapic.io>

# add start scripts
ADD init_mongo.js /init_mongo.js
ADD start.sh /start.sh
ADD init.sh /init.sh
RUN chmod +x /start.sh
RUN chmod +x /init.sh

# start
CMD /start.sh