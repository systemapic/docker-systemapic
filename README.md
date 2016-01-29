#### Docker files for Systemapic.

Minimum required docker version is 1.9.0 (due to `--build-args`)

All builds files are contained in `/build`.


Run `build/build_all.sh` to build all needed images.


All necessary code is included in `/modules/` as submodules of this repo.  
 - systemapic/wu  
   - systemapic/systemapic.js (as submodule to wu)  
 - systemapic/pile  


To fetch lastest master of all submodules, do:  
`git submodule foreach --recursive git pull origin master`