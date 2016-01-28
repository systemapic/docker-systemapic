#!/bin/bash

REFERENCE=
if test -n "$SYSTEMAPIC_SRC_PILE"; then
  REFERENCE="--reference $SYSTEMAPIC_SRC_PILE"
fi
if test "$1" = "--reference"; then
  shift
  if test -n "$1"; then
    REFERENCE="--reference $1"
  else
    echo "--reference needs a parameter"
  fi
fi

trap "echo 'Cleaning up pile'; rm -rf `dirname $0`/pile" 0

# clone
git clone --depth 1 $REFERENCE git@github.com:systemapic/pile.git

# stamp package.json with original time
cd pile
REV=$(git rev-list -n 1 HEAD 'package.json');
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1);
touch -d "$STAMP" package.json;
cd ..

# build
docker build -t systemapic/pile .
# docker build -t debug/pile:node1040 .

