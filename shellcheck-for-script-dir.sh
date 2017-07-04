#!/bin/bash

# This script is using shellcheck to check a shell script directory.
# $1: shell script dirname
# usage: bash shellcheck-for-script-dir.sh /hardenedlinux/STIG-4-Debian/scripts


ls $1  | xargs -n1 > ./script-list

if ! dpkg -s shellcheck;then
	exit 1
fi

while read line;do
	echo "--------------------------------------------------------------------------------------------------------------------------"
	shellcheck $1/${line}
	echo "--------------------------------------------------------------------------------------------------------------------------"
done < ./script-list
rm ./script-list

