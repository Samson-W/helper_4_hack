#!/bin/bash


ROOTDIR="$1"

# Traverse all files and subdirectories under the $ROOTDIR and generate hash by sha1sum  
function read_dir() 
{
	for file in `ls -A $1`               
	do
		if [ -d $1"/"${file} ] 
		then
			read_dir $1"/"${file}
		else
			shred -f -n 9 --random-source=/dev/urandom $1"/"${file}
		fi
	done
}

echo "Start--------------------------------------------------------------------"

read_dir $ROOTDIR

echo "Done---------------------------------------------------------------------"
	

