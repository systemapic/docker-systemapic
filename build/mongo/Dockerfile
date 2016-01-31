FROM mongo:latest
MAINTAINER <knutole@systemapic.com>

# start script
ADD start.sh /start.sh
RUN chmod +x /start.sh
ADD init_mongo.js /init_mongo.js

# start
CMD /start.sh