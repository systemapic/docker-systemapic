FROM systemapic/redis
ADD rtoken.conf /etc/redis/rtoken.conf
EXPOSE 6379
ENTRYPOINT ["redis-server", "/etc/redis/rtoken.conf"]
