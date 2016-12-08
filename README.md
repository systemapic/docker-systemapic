
# Mapic [![Build Status](https://travis-ci.org/mapic/mapic.png)](https://travis-ci.org/mapic/mapic)

Mapic is an Open Source Web Map Engine. 

Learn more @ https://mapic.io. For a technical overview, please see [Mapic Technical Overview](https://github.com/mapic/mapic/wiki/Mapic-Techincal-Overview).

## Install

### Install dependencies: 
- [Docker](https://docs.docker.com/engine/installation/) `>= 1.9.0`  
- [Docker Compose](https://docs.docker.com/compose/install/) `>= 1.5.2`  
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Install to localhost
Clone repository and run install:
```bash
git clone git://github.com/mapic/mapic.git
cd mapic
./install-to-localhost.sh
```
### Create User
The first user is created automatically. You can log in to https://localhost with these default credentials:  

```
username: localhost@mapic.io
password: localhost-password
```

To create another superuser, do:

```bash
# create super user
cd scripts
./create-super-user.sh 

```

### Install to custom domain
Install to localhost first, following instructions above; then see [mapic/config-domain.example.com](https://github.com/mapic/config-domain.example.com) for instructions on changing configs for custom domain.


## Usage
1. Install (see above).
2. Start server with `./restart-mapic.sh`.
3. Open your browser @ https://localhost.
4. Stop server with `./stop-mapic.sh`.


## Libraries
Mapic consists of:   
1. [Mapic Engine](https://github.com/mapic/engine)  
2. [Mapic Tileserver](https://github.com/mapic/mile)    
3. [Mapic Client library](https://github.com/mapic/mapic.js)    
4. [Mapic SDK](https://github.com/mapic/sdk) (for interacting with API programmatically)

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
