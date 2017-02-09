# simply add a debug line to postgres config

# from normal postgis image
FROM mapic/postgis:latest

# add debug line
RUN echo "log_min_messages = DEBUG2" >> /etc/postgresql/9.3/main/postgresql.conf
