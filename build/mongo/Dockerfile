FROM mongo:latest
MAINTAINER @kosjoli

ADD mongod.conf /etc/mongod.conf
RUN touch /etc/mongod.log
# CMD ["mongod", "-f", "/etc/mongod.conf", "--auth"]
CMD ["mongod", "-f", "/etc/mongod.conf"]
