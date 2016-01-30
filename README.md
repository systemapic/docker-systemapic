### Docker files for Systemapic.


#### Requirements:
Minimum required docker version is 1.9.0 (due to `--build-args`)

#### Build
All builds files are contained in `/build/`.

Do `build/build_all.sh` to build all needed docker images.

#### Run
All current run-files are contained in `/compose/`. 

Do `./restart.sh` to start compose based on `$SYSTEMAPIC_DOMAIN` (eg. `dev.systemapic.com`)


#### Repositories
All necessary code is included in `/modules/` as submodules of this repo.  
 - systemapic/wu  
   - systemapic/systemapic.js (as submodule to wu)  
 - systemapic/pile  

To fetch lastest master of all submodules, do:  
`git submodule foreach --recursive git pull origin master`