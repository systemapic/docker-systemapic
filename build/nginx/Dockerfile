##
# knutole/dev-nginx-server
#
# This creates the dev.systemapic.com front-end ngnix server, for vile.js and systemapic.js
# 

# Ubuntu 14.04 Trusty Tahyr, custom build of nginx
FROM knutole/nginx

MAINTAINER Knut Ole Sjøli <knutole@systemapic.com>

# add extras
RUN apt-get update && apt-get install -y nmap fish htop nmon bmon

# Copy latest config files
ADD ./nginx.conf /etc/nginx/
ADD ./dhparams.pem /etc/nginx/
ADD ./ssl_certificate.pem /etc/nginx/ssl/ssl_certificate.pem
ADD ./ssl_certificate.key /etc/nginx/ssl/ssl_certificate.key
ADD ./502.html /etc/nginx/error/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /etc/nginx/log/access.log
RUN ln -sf /dev/stdout /etc/nginx/log/error.log
RUN ln -sf /dev/stdout /etc/nginx/log/error.portal.log
RUN ln -sf /dev/stdout /etc/nginx/log/error.tileserver.log

# open ports
EXPOSE 80
EXPOSE 443

# enable terminal
ENV TERM xterm

# Start nginx
WORKDIR /etc/nginx
CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]
