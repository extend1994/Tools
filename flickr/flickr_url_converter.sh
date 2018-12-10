#!/usr/bin/env bash

#url=$(node flickr.js)
#echo "echo url!"
#echo $url
READFILE=$1

echo -n "" > replace.sh

lines=$(wc $1 | awk '{print $1}')
counter=0
while read line; do
  ((counter+=1))
  photo_id=$(echo $line | awk -F '/' '{print $6}')
  url=$(node flickr.js $photo_id)
  now=$(echo "$counter $lines" | awk '{printf "%.3f", $1*100/$2}')
  echo -ne "$now%\r"
  echo -n "sed 's/" >> replace.sh
  echo -n $line | sed 's/\//\\\//g' >> replace.sh
  echo -n "/" >> replace.sh
  echo -n $url | sed 's/\//\\\//g' >> replace.sh
  echo "/g' *.md" >> replace.sh
done < $READFILE
