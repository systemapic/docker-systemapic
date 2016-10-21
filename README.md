# Dockerized Mapic Engine

Mapic Docker Images @ [Docker Hub](https://hub.docker.com/u/mapic/dashboard/)

## Installation
Clone repository and run install:
```bash
git clone git@github.com:mapic/dockerized.git
cd dockerized
./install-to-localhost.sh
```

## Usage

1. Install (see above).
2. `cd dockerized/compose/` and run `./restart.sh`. 
3. Open your browser @ https://localhost.



#### Set environment

Set `SYSTEMAPIC_DOMAIN` environment variable on your localhost
(eg. `dev.systemapic.com`, without `https://`).
This is a required ENV variable.
Default value is `SYSTEMAPIC_DOMAIN=localhost`.

Set `SYSTEMAPIC_PRODMODE=false` for running code from `modules/`.
Set to `true` for running latest git repository code,
with prod-flags set in servers. 


## Depends

Minimum required `Docker` version: 1.9.0 (due to `--build-arg`)  
Recommended `Docker Compose` version: 1.5.2  

All relevant code is included in `/modules/` as submodules of this repo.  
