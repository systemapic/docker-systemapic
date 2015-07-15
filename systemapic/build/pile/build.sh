#!/bin/bash

# clone
git clone git@github.com:systemapic/pile.git

# stamp package.json with original time
cd pile
REV=$(git rev-list -n 1 HEAD 'package.json');
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" package.json;
cd ..

# build
docker build -t systemapic/pile .

# clean up
rm pile/ -r
