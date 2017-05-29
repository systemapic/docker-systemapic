
# Mapic [![Build Status](https://travis-ci.org/mapic/mapic.png)](https://travis-ci.org/mapic/mapic)

Mapic is an Open Source Web Map Engine. 

Learn more @ https://mapic.io. For a technical overview, please see [Mapic Technical Overview](https://github.com/mapic/mapic/wiki/Mapic-Techincal-Overview).


## Install
This will install mapic and configure it for `localhost`. For custom domain configuration, see below.

```bash
# install mapic
wget -qO- https://get.mapic.io/ | sh
```

## Usage
1. Start server with `mapic start`.
2. Open your browser @ https://localhost (or other configured domain).
3. Stop server with `mapic stop`.

See `mapic` command for more options.

### Dependencies: 
- [Docker](https://docs.docker.com/engine/installation/) `>= 1.9.0`  
- [Docker Compose](https://docs.docker.com/compose/install/) `>= 1.5.2`  
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

(`mapic` cli will try to install these automatically on Ubunut and OSX.)

### Create user
Create a user with the `mapic` cli:

```bash
# create user
mapic api user create

# promote to superuser
mapic api user super 

```

### Install to custom domain
```bash

# set mapic domain
mapic config set MAPIC_DOMAIN domain.example.com

# install mapic
mapic install mapic

```

## Libraries
Mapic consists of:   
1. [Mapic Engine](https://github.com/mapic/engine)  
2. [Mapic Mile Tileserver](https://github.com/mapic/mile)    
3. [Mapic Javascript Client library](https://github.com/mapic/mapic.js)    

Mapic is built on Docker. Docker Images for Mapic are available on the [Docker Hub](https://hub.docker.com/u/mapic/).

## Licence
Mapic is built entirely open source. We believe in a collaborative environment for creating strong solutions for an industry that is constantly moving. The Mapic platform is open for anyone to use and contribute to, which makes it an ideal platform for government organisations and NGO's, as well as for-profit businesses.

Mapic is licenced under the [AGPL licence](https://github.com/mapic/mapic/blob/master/LICENCE).

## Project contributors
- [Jørgen Evil Ekvoll](https://github.com/jorgenevil)
- [Magdalini Fotiadou](https://github.com/mft74)
- [Terrence Lam](https://github.com/skyuplam)
- [Sandro Santilli](https://github.com/strk)
- [Knut Ole Sjøli](https://github.com/knutole)
- [Shahjada Talukdar](https://github.com/destromas1)
- [Igor Ziegler](https://github.com/igorziegler)
