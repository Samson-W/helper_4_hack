#! /bin/bash
value1=$1
value2=$2

if [ $value1 \> $value2 ]
then
   echo "$value1 大于 $value2"
elif [ $value1 \< $value2 ]
then
   echo "$value1 小于 $value2"
else
   echo "$value1 等于 $value2"
fi
