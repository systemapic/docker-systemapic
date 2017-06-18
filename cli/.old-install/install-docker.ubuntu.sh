#!/bin/bash

# install docker community edition
# updated May 5th 2017
#
# https://docs.docker.com/engine/installation/linux/ubuntu/

# install docker-ce
sudo apt-get remove -y docker docker-engine
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce


# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# verify version
clear
echo "Installed Docker Community Edition and Docker Compose:"
docker version
docker-compose version