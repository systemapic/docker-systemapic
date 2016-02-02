#!/bin/bash
read -p "Update all repos? [git submodule foreach --recursive git pull origin master]  (y/n):" -n 1 -r

echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	cd /docks/
	git pull origin master
	git submodule foreach --recursive git pull origin master

	read -p "Run all tests on new code? [git submodule foreach --recursive git pull origin master]  (y/n):" -n 1 -r

fi


