# Dockerized Mapic Engine

Mapic Docker Images @ [Docker Hub](https://hub.docker.com/u/mapic/dashboard/)

## Install
Clone repository and run install:
```bash
git clone git@github.com:mapic/dockerized.git
cd dockerized
./install-to-localhost.sh
```

#### Install to custom domain
Run normal install above, then see https://github.com/mapic/config-domain.example.com for instructions on changing configs for custom domain.

#### Set environment
Set `MAPIC_DOMAIN` environment variable on your localhost
(eg. `dev.mapic.io`, without `https://`).
This is a required [ENV variable](https://www.schrodinger.com/kb/1842).

Default value is `MAPIC_DOMAIN=localhost`.


## Usage
1. Install (see above).
2. `cd dockerized/compose/` and run `./restart.sh`. 
3. Open your browser @ https://localhost.



## Depends
Minimum required `Docker` version: 1.9.0 (due to `--build-arg`)  
Recommended `Docker Compose` version: 1.5.2  
