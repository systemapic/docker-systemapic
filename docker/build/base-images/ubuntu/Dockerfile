##
# mapic/ubuntu:latest
#

# base image
FROM ubuntu:trusty

# maintainer
MAINTAINER @kosjoli

# upgrade ubuntu
RUN apt-get update -y && apt-get install software-properties-common -y 
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

# install basics
RUN apt-get update -y
RUN apt-get install -y \ 
	wget \
	fish \
	htop \
	curl \
	unzip \
	bmon \
	nmon \
	nmap \
	pigz \
	build-essential \
  python-software-properties \
  subversion \
  zip \
  mlocate \
  redis-tools \ 
  git \
  protobuf-compiler \
  libprotobuf-dev \
  apt-transport-https \
  make

# ensure everything up to date
RUN apt-get update --fix-missing -y

# install node-js
ADD ./install-nodejs.sh /tmp/
RUN sh /tmp/install-nodejs.sh
ENV NODE_PATH /usr/local/lib/node_modules

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y
RUN apt-get install yarn -y

# install node deps
RUN yarn global add grunt-cli
RUN yarn global add nodemon
RUN yarn global add forever
RUN yarn global add mocha
RUN yarn global add node-pre-gyp 
RUN yarn global add npm-check-updates 
RUN yarn global add karma 

# set terminal
ENV TERM xterm

# entrypoint
CMD ['bash']