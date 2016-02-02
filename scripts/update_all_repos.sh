#!/bin/bash

function pull_all() {
	echo "Pulling masters..."
	cd /docks/
	git pull origin master
	git submodule foreach --recursive git pull origin master
}

function test_all() {
	cd /docks/scripts/
	./test.sh
}

# confirm pull
read -p "Update all repos? 
  [git submodule foreach --recursive git pull origin master]  (y/n):" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# pull all
	pull_all

	# confirm test
	read -p "Run all tests on new code? [git submodule foreach --recursive git pull origin master]  (y/n):" -n 1 -r
	echo

	# run tests
	if [[ $REPLY =~ ^[Yy]$ ]]; then test_all; fi
fi