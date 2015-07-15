##
# knutole/dev-nginx-server
#
# This creates the dev.systemapic.com front-end ngnix server, for vile.js and systemapic.js
# 

# Ubuntu 14.04 Trusty Tahyr, custom build of nginx
FROM knutole/nginx

MAINTAINER Knut Ole Sjøli <knutole@systemapic.com>

# add extras
RUN apt-get update && apt-get install -y nmap

# Copy latest config files
ADD ./dev.systemapic.nginx.conf /etc/nginx/
ADD ./systemapic_com.crt /etc/nginx/ssl/systemapic_com.crt
ADD ./systemapic_com.key /etc/nginx/ssl/systemapic_com.key
ADD ./502.html /etc/nginx/error/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /etc/nginx/log/access.log
RUN ln -sf /dev/stdout /etc/nginx/log/error.log

EXPOSE 80
EXPOSE 443

# Start nginx
WORKDIR /etc/nginx
CMD ["nginx", "-c", "/etc/nginx/dev.systemapic.nginx.conf"]
