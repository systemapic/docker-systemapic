##
# mapic/nginx:latest
#

# base image
FROM mapic/ubuntu:latest

# Ubuntu 14.04 Trusty Tahyr
# FROM ubuntu:trusty

MAINTAINER Knut Ole Sjøli <knutole@mapic.io>

# # Install basic dependencies
# RUN apt-get update -y && apt-get install -y \
#     software-properties-common \
#     python-software-properties \
#     build-essential \
#     wget \
#     subversion \
#     unzip \
#     htop \
#     fish \
#     tar \
#     libgcrypt11-dev \
#     zlib1g-dev \
#     nmap \
#     fish \
#     htop \
#     nmon \
#     bmon



# install openssl
ADD ./install-openssl.sh /tmp/
RUN sh /tmp/install-openssl.sh

# install nginx
ADD ./install-nginx.sh /tmp/
RUN sh /tmp/install-nginx.sh

# copy latest config files
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

# workdir
WORKDIR /mapic/config

# entrypoint
CMD ["nginx", "-c", "/mapic/config/nginx.conf"]
