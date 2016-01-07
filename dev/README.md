## Docker Compose

This is where everything is run from.  


- To start server and all containers: `./restart.sh`
- To build all containers (given that dependency containers already built): `./build_all.sh`
- To build dependencies (will take at least 20mins): `./build_all_deps.sh`