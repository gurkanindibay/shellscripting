#!/bin/bash

echo 'Count, Ip,location'
grep 'Failed password for' syslog-sample | awk '{print $(NF-3)}'|sort|uniq -c| sort -n $1 -r|awk '{if($1>10) print $1" "$2" "  }' | while read -r COUNT IP
do
  LOCATION=$(geoiplookup "${IP}"|awk -F ':' '{print $2}'|awk -F ',' '{print $2}')

  echo "${COUNT},${IP},${LOCATION}"
done