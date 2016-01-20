FROM mongo:latest
MAINTAINER @kosjoli

# start script
ADD start.sh /etc/start.sh
RUN chmod +x /etc/start.sh
ADD first_run.js /etc/first_run.js

# config
ADD mongod.conf /etc/mongod.conf
RUN touch /etc/mongod.log

# start
CMD /etc/start.sh
# CMD ["mongod", "-f", "/etc/mongod.conf", "--auth"]
# CMD ["mongod", "-f", "/etc/mongod.conf"]

