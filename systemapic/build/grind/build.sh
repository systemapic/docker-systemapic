#!/bin/bash

# clone
git clone git@github.com:systemapic/vile-grind.git

# stamp package.json with original time
cd vile-grind
REV=$(git rev-list -n 1 HEAD 'package.json');
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" package.json;
cd ..

# build
docker build -t systemapic/grind .

# clean up
rm vile-grind/ -r
