#!/bin/bash

BD=`dirname $0`

trap "echo 'Cleaning up downloaded repos'; rm -rf $BD/wu; rm -rf $BD/public" 0

# docker doesn't allow ADDing paths above Dockerfile dirname
mkdir wu && cp -r ../../modules/wu/* wu || exit 1

# stamp package.json with original time
cd wu &&
REV=$(git rev-list -n 1 HEAD 'package.json') \
STAMP=$(git show --pretty=format:%ai --abbrev-commit "$REV" | head -n 1) \
touch -d "$STAMP" package.json &&
cd - || exit 1


# build
docker build -t systemapic/wu .

