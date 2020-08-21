#!/bin/bash

# usage: 
# bash ./genps_01.sh psstr

USAGEHELP="usage: bash ./genps.sh psstr"

PSSTR="$1"
LENGTH=$(echo "${PSSTR}" | wc -c)
((CUTEND=$LENGTH+19))

if [ -z "${PSSTR}" ];then
	echo "str is empty."
	echo ${USAGEHELP}
	exit 1
fi

if [ ${CUTEND} -gt 128 ];then
	echo "length is too long."
	echo ${USAGEHELP}
	exit 1
fi
PSSTRNOW=$(echo "${PSSTR}" | openssl sha512 | openssl base64 | openssl sha512 | openssl base64 | openssl sha512 | awk '{printf $2}' )
PSSTR_ONLYNUM=$(echo "$PSSTRNOW" | tr -cd "[0-9]")
echo "ONLYNUM is $PSSTR_ONLYNUM"
#| cut -c${LENGTH}-${CUTEND})

echo "PSSTR IS ${PSSTRNOW}"

