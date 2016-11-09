FROM mongo:latest
MAINTAINER <knutole@mapic.io>

# start scripts
ADD start.sh /start.sh
RUN chmod +x /start.sh
ADD init_mongo.js /init_mongo.js
ADD initialize.sh /initialize.sh
RUN chmod +x /initialize.sh

# start
CMD /start.sh