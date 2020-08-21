#!/bin/bash

# usage: 
# bash ./genps.sh psstr

USAGEHELP="usage: bash ./genps.sh psstr"

PSSTR="$1"
LENGTH=$(echo "${PSSTR}" | wc -c)
((CUTEND=$LENGTH+19))

echo "PSSTR length is $LENGTH"
echo "CUTEND is $CUTEND"

if [ -z "${PSSTR}" ];then
	echo "str is empty."
	echo ${USAGEHELP}
	exit 1
fi
#if [ ${CUTEND} -gt 128 ];then
if [ ${CUTEND} -gt 184 ];then
	echo "length is too long."
	echo ${USAGEHELP}
	exit 1
fi

PSSTRNOW=$(echo "${PSSTR}" | openssl sha512 | base64 -w 0 | openssl sha512 | base64 -w 0 | openssl sha512 | base64 -w 0)
BIT20PSSTR=$(echo "$PSSTRNOW" | cut -c${LENGTH}-${CUTEND})
PSSTR_ONLYNUM=$(echo "$PSSTRNOW" | tr -cd "[0-9]")
echo "PSSTR IS ${PSSTRNOW}"
echo "ONLYNUM is $PSSTR_ONLYNUM"
echo "BIT20PSSTR is $BIT20PSSTR"

