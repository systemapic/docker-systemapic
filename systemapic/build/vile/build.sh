#!/bin/bash

# clone
git clone git@github.com:systemapic/vile.git

# stamp package.json with original time
cd vile
REV=$(git rev-list -n 1 HEAD 'package.json');
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" package.json;
cd ..

# build
docker build -t systemapic/vile .

# clean up
rm vile/ -r
