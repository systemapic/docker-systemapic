# Dockerized Mapic Engine

Mapic Docker Images @ [Docker Hub](https://hub.docker.com/u/mapic/dashboard/)

## Installation
Clone repository and run install:
```bash
git clone git@github.com:mapic/dockerized.git
cd dockerized
./install.sh
```

## Usage




#### Set environment

Set `SYSTEMAPIC_DOMAIN` environment variable on your localhost
(eg. `dev.systemapic.com`, without `https://`).
This is a required ENV variable.
Default value is `SYSTEMAPIC_DOMAIN=localhost`.

Set `SYSTEMAPIC_PRODMODE=false` for running code from `modules/`.
Set to `true` for running latest git repository code,
with prod-flags set in servers. 


#### Start Systemapic Cloud Server

Do `compose/restart.sh` to start all containers. 

## Install

All builds files are contained in
[https://github.com/mapic/dockerized/tree/master/build](`build/`)
folder. 

Run `build/build_all.sh` to build all required Docker images.

## Depends

Minimum required `Docker` version: 1.9.0 (due to `--build-arg`)  
Recommended `Docker Compose` version: 1.5.2  

All necessary code is included in `/modules/` as submodules of this repo.  
 - systemapic/wu  
   - systemapic/systemapic.js (as submodule to wu)  
 - systemapic/pile  

To init submodules (and update them to the expected version), do:
`git submodule update --init --recursive`

To fetch lastest master of all submodules, do:  
`git submodule foreach --recursive git pull origin master`  
