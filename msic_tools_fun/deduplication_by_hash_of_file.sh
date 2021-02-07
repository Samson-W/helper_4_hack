#!/bin/bash
# This script is for find repeated files

# $1 is begin root dir name
# $2 is hash log file

# Usage: bash ./deduplication_by_hash_of_file.sh /home/testuser/date /home/testuser/find_repeated_files.log

function usege_help()
{
	echo "bash deduplication_by_hash_of_file.sh DIR find_repeated_log_file"
	exit 1
}

if [ $# -lt 2 ]; then
	echo "Too few parameters."
	usege_help
elif [ $# -gt 2 ]; then
	echo "Too many parameters."
	usege_help
else
	:
fi

ROOTDIR="$1"
HASHFILENAME="$2"
HASHFILE_ONLYHASH="${HASHFILENAME}_only_hash"
UNIQ_RESULT_FILE="${HASHFILENAME}_uniq"
REPEATED_RESULT_FILE="${HASHFILENAME}_repeated_reuslt"
echo > "${HASHFILENAME}"

# This is to solve the problem of spaces in the file name 
d_IFS=$IFS
c_IFS=$'\n'
IFS=$c_IFS

# Traverse all files and subdirectories under the $ROOTDIR and generate hash by sha1sum  
function read_dir() 
{
	for file in `ls -A $1`               
	do
		if [ -d $1"/"${file} ] 
		then
			read_dir $1"/"${file}
		else
			sha1sum $1"/"${file} >> "${HASHFILENAME}"
		fi
	done
}

echo "Start--------------------------------------------------------------------"

read_dir $ROOTDIR
echo > $HASHFILE_ONLYHASH
echo > $UNIQ_RESULT_FILE
echo > $REPEATED_RESULT_FILE
sort $HASHFILENAME | awk '{ print $1 }' > $HASHFILE_ONLYHASH
uniq -d $HASHFILE_ONLYHASH > $UNIQ_RESULT_FILE
if [ $(cat $UNIQ_RESULT_FILE | wc -l) -eq 0 ]; then
	echo "Not find the repeated file."
	rm $REPEATED_RESULT_FILE
else
	echo "Repeated file info is restory in $REPEATED_RESULT_FILE."
	cat $UNIQ_RESULT_FILE | while read HASHV; do 
		grep $HASHV $HASHFILENAME >> $REPEATED_RESULT_FILE
		echo '' >> $REPEATED_RESULT_FILE
	done
fi

echo "Done---------------------------------------------------------------------"
	
IFS=$d_IFS

