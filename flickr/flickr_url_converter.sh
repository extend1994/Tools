#!/usr/bin/env bash

READFILE=$1

if [ $# -eq 0 ]; then
  echo "Usage: ./<path_to>/flickr_url_converter.sh <READFILE>"
  flag=0
fi

echo -n "" > replace.sh

lines=$(wc $READFILE | awk '{print $1}')
counter=0
while read line; do
  ((counter+=1))
  photo_id=$(echo $line | awk -F '/' '{print $6}')
  # Get gerneral urls using photo id from flickr
  url=$(node flickr.js $photo_id)
  now=$(echo "$counter $lines" | awk '{printf "%.3f", $1*100/$2}')
  # Show how much work has been done
  echo -ne "$now%\r"
  # Generate corresponding `sed` command to replace.sh in order to convert url in .md
  # e.g. `sed 's///g'` *.md
  echo -n "sed 's/" >> replace.sh
  echo -n $line | sed 's/\//\\\//g' >> replace.sh
  echo -n "/" >> replace.sh
  echo -n $url | sed 's/\//\\\//g' >> replace.sh
  echo "/g' *.md" >> replace.sh
done < $READFILE
