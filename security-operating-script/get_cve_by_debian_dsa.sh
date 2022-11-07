#!/bin/bash

DLAFILENAME=$1
DOWNLOADCVEINFODIR=${DLAFILENAME}-CVE-detail-dir
CVELISTLOG=${DLAFILENAME}-CVE-list.log

TMPCOUNT=$(grep "CVE-" ${DLAFILENAME} | awk -F'CVE-' '{print NF-1}') 
CVECOUNT=$[${TMPCOUNT}/2]

for i in $(seq 1 ${CVECOUNT})
do
	CVENUMBER=$(grep -i "cve" ${DLAFILENAME} | awk '-F</a>' "{print \$${i}}" | awk -F'href' '{print $2}' | awk -F'>' '{print $2}') 
	wget -c https://nvd.nist.gov/vuln/detail/${CVENUMBER} -P ${DOWNLOADCVEINFODIR}
done

