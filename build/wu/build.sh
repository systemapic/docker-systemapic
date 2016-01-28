#!/bin/bash

WU_REFERENCE=
if test -n "$SYSTEMAPIC_SRC_WU"; then
  WU_REFERENCE="--reference $SYSTEMAPIC_SRC_WU"
fi

JS_REFERENCE=
if test -n "$SYSTEMAPIC_SRC_JS"; then
  JS_REFERENCE="--reference $SYSTEMAPIC_SRC_JS"
fi

trap "echo 'Cleaning up wu'; rm -rf `dirname $0`/pile" 0

# clone
git clone $WU_REFERENCE git@github.com:systemapic/wu.git wu

# stamp package.json with original time
cd wu &&
REV=$(git rev-list -n 1 HEAD 'package.json') \
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1) \
touch -d "$STAMP" package.json &&
cd - || exit 1

# add systemapic.js to public/ 
cd wu &&
git clone $JS_REFERENCE \
  git@github.com:systemapic/systemapic.js.git public &&
cd - || exit 1

# build
docker build -t systemapic/wu .

