# Ubuntu 14.04 Trusty Tahyr
FROM ubuntu:trusty

MAINTAINER Knut Ole Sjøli <knutole@systemapic.com>

# Ensure the package repository is up to date
# RUN apt-get update -y

# Install basic dependencies
RUN apt-get update -y && apt-get install -y \
    software-properties-common \
    python-software-properties \
    build-essential \
    wget \
    subversion \
    unzip \
    htop \
    fish \
    tar \
    libgcrypt11-dev \
    zlib1g-dev \
    nmap \
    fish \
    htop \
    nmon \
    bmon

# Install NginX
ADD ./install-nginx.sh /tmp/
RUN sh /tmp/install-nginx.sh

# Copy latest config files
# ADD ./nginx.conf /etc/nginx/
# ADD ./dhparams.pem /etc/nginx/
# ADD ./ssl_certificate.pem /etc/nginx/ssl/ssl_certificate.pem
# ADD ./ssl_certificate.key /etc/nginx/ssl/ssl_certificate.key
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
# WORKDIR /etc/nginx
WORKDIR /systemapic/config
# CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["nginx", "-c", "/systemapic/config/nginx.conf"]
