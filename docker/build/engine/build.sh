#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# build
docker build -t mapic/engine:latest . || abort "Build failed!"
