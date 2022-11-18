#!/bin/sh

echo "Automated CPU Temperature Monitor"
echo "(^C to quit)"

while :
do

TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

ORIGINAL_TEMP=$(cat $TEMP_FILE)
TEMP_C=$((ORIGINAL_TEMP/1000))
TEMP_F=$(($TEMP_C * 9/5 + 32))
date=$(date '+(%d-%m-%Y %H:%M:%S)')

  echo $date
  echo "Current Temperature:" $TEMP_C C
  sleep 60
done