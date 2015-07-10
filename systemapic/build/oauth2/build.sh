#!/bin/bash

# clone
git clone git@github.com:systemapic/Oauth2orizeRecipes.git

# stamp package.json with original time
cd Oauth2orizeRecipes/authorization-server
REV=$(git rev-list -n 1 HEAD 'package.json');
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" package.json;
cd ../..

# build
docker build -t systemapic/oauth2 .

# clean up
rm Oauth2orizeRecipes/ -r
