#!/bin/bash

# clone
git clone git@github.com:systemapic/wu.git wu

# stamp package.json with original time
cd wu
REV=$(git rev-list -n 1 HEAD 'package.json');
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" package.json;
cd ..

# build
docker build -t systemapic/wu .

# clean up
rm wu/ -r