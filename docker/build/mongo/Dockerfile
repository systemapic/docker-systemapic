FROM mongo:latest
MAINTAINER <knutole@mapic.io>

# start scripts
ADD start.sh /start.sh
RUN chmod +x /start.sh
ADD init_mongo.js /init_mongo.js
ADD init.sh /init.sh
RUN chmod +x /init.sh

# start
CMD /start.sh