FROM systemapic/redis
ADD rkue.conf /etc/redis/rkue.conf
EXPOSE 6379
ENTRYPOINT ["redis-server", "/etc/redis/rkue.conf"]
