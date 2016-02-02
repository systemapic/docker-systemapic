# docker-systemapic
[Systemapic](https://systemapic.com) Cloud Server

## Usage
All current run-files are contained in `/compose/`. 

#### Set environment
Set `$SYSTEMAPIC_DOMAIN` environment variable on your localhost (eg. `dev.systemapic.com`, without `https://`). This is a required ENV variable. Default value is `$SYSTEMAPIC_DOMAIN=localhost`.

Set `$SYSTEMAPIC_PRODMODE=false` for running code from `modules/`. Set to `true` for running latest git repository code, with prod-flags set in servers. 


#### Start Systemapic Cloud Server
Do `compose/restart.sh` to start all containers. 


## Install

All builds files are contained in [https://github.com/systemapic/docker-systemapic/tree/master/build](`build/`) folder. 

Run `build/build_all.sh` to build all required Docker images.

## Depends
Minimum required `Docker` version: 1.9.0 (due to `--build-arg`)  
Recommended `Docker Compose` version: 1.5.2  

All necessary code is included in `/modules/` as submodules of this repo.  
 - systemapic/wu  
   - systemapic/systemapic.js (as submodule to wu)  
 - systemapic/pile  


To init submodules, do:
`git submodule update --init`  

To fetch lastest master of all submodules, do:  
`git submodule foreach --recursive git pull origin master`  
