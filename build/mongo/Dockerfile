FROM mongo:latest
MAINTAINER @kosjoli

# start script
ADD start.sh /etc/start.sh
RUN chmod +x /etc/start.sh
ADD init_mongo.js /etc/init_mongo.js

# config
ADD mongod.conf /etc/mongod.conf
RUN touch /etc/mongod.log

# start
CMD /etc/start.sh
