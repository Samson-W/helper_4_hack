#!/bin/bash

# usage: 
# bash ./genps.sh psstr

USAGEHELP="usage: bash ./genps.sh psstr"

PSSTR="$1"
LENGTH=$(echo "${PSSTR}" | wc -c)
((CUTEND=$LENGTH+15))

if [ -z "${PSSTR}" ];then
	echo "str is empty."
	echo ${USAGEHELP}
	exit 1
	if [ ${CUTEND} -gt 512 ];then
		echo "length is too long."
		echo ${USAGEHELP}
		exit 1
	fi
fi

PSSTRNOW=$(echo "${PSSTR}" | openssl sha512 | openssl base64 | openssl sha512 | openssl base64 | openssl sha512 | awk '{printf $2}' | cut -c${LENGTH}-${CUTEND})

echo "PSSTR IS ${PSSTRNOW}"

