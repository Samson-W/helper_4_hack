#!/bin/bash
# Auther: Samson-W
# Data: 2022.10.16

# This script is check CVE is fixed. Get these info from https://security-tracker.debian.org/tracker/CVEID
# Usage: bash check-is-fixed-by-CVEID.sh buster CVELISTFILE DOWNLOADHTMLDIRNAME

# This result log file path, logfile include CVEID, PKGname, FIXstatus, security FIXEDversion, stable FIXEDversion
CHECKRESULTLOG="$2-check-fixed-result.log"
echo "CVEID, PKGname, FIXstatus, SEC-FIXEDversion, stable-FIXEDversion"> $CHECKRESULTLOG

# download CVE traceker html from  https://security-tracker.debian.org/tracker/$cveid
# paramers: $1 is CVEID  $2 is download html storager dir
# Example: $1=CVE-2022-20001 $2=/tmp/DIRname 
downloadhtml()
{
	wget --no-check-certificate  -c https://security-tracker.debian.org/tracker/$1 -O $2/$cveid
}

# Paramers: $1 download CVE html name 
# Return: pkg name
get_pkgname()
{
	# When a CVE affects multiple packages
	if	[ $(cat $1 | sed 's/tracker\/source/&\n/g' | grep buster -c ) -gt 1 ]; then
		PKGNAME=$(cat $1 | sed 's/tracker\/source/&\n/g' | grep buster | awk -F'-package/' '{print $2}' | awk -F'">' '{print $1}' | sort | uniq | tr '\n' ' ')
	else
		# When a CVE onle effects a package
		PKGNAME=$(cat  $1  | awk -F'/tracker/source-package/' '{print $2}' | awk -F'"' '{print $1}' | grep -v "^$")
	fi
	if [ "${PKGNAME}null" == "null" ]; then
        echo "$cveid pkgname is not get!!!"
        echo "$cveid PKGNAMENOTFIND"
		PKGNAME="PKGNAMENOTFIND"
    else
        echo "$cveid $PKGNAME"
    fi
}

# check CVE has fixed in release version 
# Paramers: $1 download CVE html name  $2 debina release namecode
check_has_fixed()
{	
	if [ $(cat $1 | grep "NOT-FOR-US" -c) -gt 0 ]; then
		# NOT-FOR-US is mean not attack 
		CVEFIXED=3
	else
		if [ $(cat $1 | awk -F'Status' '{print $2}' | grep "<td>$2" | awk -F'<td>' '{print $5}' | grep 'fixed' -c) -gt 0 ]; then
			CVEFIXED=0
			# If fixed in security mirror, set ISSECURITYMIRROR=0, else ISSECURITYMIRROR=1
			ISSECURITYMIRROR=1
		else
			if [ $(cat $1 | awk -F'Status' '{print $2}' | sed 's/<tr>/&\n/g' | grep "$2 (security)" -c) -gt 0 ]; then
				if [ $(cat $1 | awk -F'Status' '{print $2}' | sed 's/<tr>/&\n/g' | grep "$2 (security)" | grep 'fixed' -c) -gt 0 ]; then
					CVEFIXED=0
					# If fixed in security mirror, set ISSECURITYMIRROR=0, else ISSECURITYMIRROR=1
					ISSECURITYMIRROR=0
				else
					CVEFIXED=1
				fi
			else
				CVEFIXED=1
			fi
		fi
	fi
}

# paramers: $1 is download CVE html file name  $2 is debian release codename
get_fixed_version()
{
	FIXEDVER=$(cat $1 | awk -F'Status' '{print $2}' | sed 's/<tr>/&\n/g' |  grep "$2.*fixed" | grep -v "$2.*security.*fixed" |awk -F'<td>' '{print $4}' | awk -F'</td>' '{print $1}' | sort | uniq | tr '\n' ' ')
	if [ $(cat $1 |awk -F'Status' '{print $2}' | sed 's/<tr>/&\n/g' |  grep "$2.*security.*fixed" -c) -gt 0 ]; then
		FIXEDVERSEC=$(cat $1 |awk -F'Status' '{print $2}' | sed 's/<tr>/&\n/g' |  grep "$2.*security.*fixed" | awk -F'<td>' '{print $4}' | awk -F'</td>' '{print $1}' | sort | uniq | tr '\n' ' ')
	fi
}

# Paramers: 
# $1=suite  example: when OS is debian10 $1=buster, when OS is debian11 $1=bullseye
# $2 is CVE list file
# $3 is download html storager dir
for cveid in $(cat $2)
do	
	# init ver
	CVEFIXED=1
	FIXEDVERSEC=''
	FIXEDVER=''
	downloadhtml $cveid $3
	get_pkgname $3/$cveid
	echo "pkgname is $PKGNAME"
	check_has_fixed $3/$cveid $1
	if [ $CVEFIXED -eq 3 ]; then
		echo "$cveid is NOT-FOR-US, not attack!"
		echo "$cveid, $PKGNAME, NOT-FOR-US, ,"  >> $CHECKRESULTLOG
	elif [ $CVEFIXED -eq 0 ]; then
		echo "$cveid has fixed."
		get_fixed_version $3/$cveid $1
		echo "$cveid, $PKGNAME, fixed, $FIXEDVERSEC, $FIXEDVER" >> $CHECKRESULTLOG
	else
		echo "$cveid is not fix!"
		echo "$cveid, $PKGNAME, nofix, ,"  >> $CHECKRESULTLOG
	fi
done

