#!/bin/bash

# Author : Samson W (samson@hardenedlinux.org)
# usage: 
# bash ./genps.sh psstr
# This script program realizes the generation of a 20-character password, 
# including uppercase and lowercase, numbers, and special symbols, 
# and the generated password string contains at least three types.

USAGEHELP="usage: bash ./genps.sh psstr"
PSLEN=20

PSSTR="$1"
LENGTH=$(echo "${PSSTR}" | wc -c)
((CUTEND=$LENGTH+$PSLEN-1))

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

SPECIALCHARS=('!' '@' '#' '$' '%' '^' '&' '*' '(' ')' '_' '-' '+' '=' '~' '`' ';' ':' ',' '<' '.' '>' '[' ']' '{' '}' '|' '\' '/' '?' '"' "'") 

if [ $(uname -o) == "Android" ]; then
	TMEPFILE='./tmpnumber'
else
	TMEPFILE='/tmp/tmpnumber'
fi


getindexnum ()
{
	echo "${PSSTR}" | sha512sum | awk '{print $1}' | tr -cd "[0-9]" | sed 's/./&\n/g' > $TMEPFILE
	sum=0
	while read a
	do
#    	echo $a
		((sum=sum+a))
	done < $TMEPFILE
	echo > $TMEPFILE

	echo "sum is $sum"
	((indexnum=$sum%$PSLEN))
	if [ $indexnum -eq 0 ]; then
		echo "indexnum is eq 0, so +1"
		((indexnum=indexnum+1))
	fi
	echo "index number is $indexnum"
}

getspecharindex ()
{
	echo "${PSSTR}" | sha512sum | awk '{print $1}' | base64 -w 0 | sha512sum | awk '{print $1}' | tr -cd "[0-9]" | sed 's/./&\n/g' > $TMEPFILE
	sum=0
	while read a
	do
#    	echo $a
		((sum=sum+a))
	done < $TMEPFILE
	echo > $TMEPFILE

	echo "sum is $sum"
	((speindexnum=$sum%${#SPECIALCHARS[@]}))
	if [ $speindexnum -eq 0 ]; then
		echo "speindexnum is eq 0, so +1"
		((speindexnum=speindexnum+1))
	fi
	echo "special index number is $speindexnum"
}

replacechar ()
{	
	NOSPEPSSTR=$1
	echo "$NOSPEPSSTR" | sed 's/./&\n/g' > $TMEPFILE
	case $speindexnum in 
	6)
		sed -i "${indexnum}s/./\&/" $TMEPFILE
	;;
	27)
		sed -i "${indexnum}s/./\\\/" $TMEPFILE
	;;
	28)
		sed -i "${indexnum}s/./\//" $TMEPFILE
	;;
	*)
		sed -i "${indexnum}s/./${SPECIALCHARS[$speindexnum]}/" $TMEPFILE
	;;
	esac
	SPEPSSTR=$(cat $TMEPFILE | tr '\n' " " | sed 's/[[:space:]]//g')
	echo "Special passwd str is $SPEPSSTR"
}


PSSTRNOW=$(echo "${PSSTR}" | sha512sum | awk '{print $1}' | base64 -w 0 | sha512sum | awk '{print $1}' | base64 -w 0 | sha512sum | awk '{print $1}' | base64 -w 0 | sha512sum | awk '{print $1}' | base64 -w 0 | sha512sum | awk '{print $1}' | base64 -w 0 )

getindexnum 
getspecharindex

echo "Special char is ${SPECIALCHARS[$speindexnum]}"

BIT20PSSTR=$(echo "$PSSTRNOW" | cut -c${LENGTH}-${CUTEND})

replacechar $BIT20PSSTR

PSSTR_ONLYNUM=$(echo "$PSSTRNOW" | tr -cd "[0-9]")
echo "PSSTR IS ${PSSTRNOW}"
echo "ONLYNUM is $PSSTR_ONLYNUM"
echo "BIT20PSSTR is $BIT20PSSTR"

rm $TMEPFILE

