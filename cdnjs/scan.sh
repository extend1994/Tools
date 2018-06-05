#!/usr/bin/env bash
all_lib=($(curl -s https://api.cdnjs.com/libraries?search=| jq .results[].name -r))
lib_num=${#all_lib[@]}
lib_num=$(($lib_num-1))
echo "Scanning the libraries without license(s)..."
#echo "" > parsed_url.json # clean the content of parsed_url.json
for a in $(seq 0 $lib_num)
do
  #lib_name=$(cat cdnjs/ajax/libs/${all_lib[$a]}/package.json | jq '{name: .name, license: .license, licenses: .licenses,  repo: .repository} | select((.license == null and .licenses == null ) and .repo != null)' | jq -r .name)
  cat cdnjs/ajax/libs/${all_lib[$a]}/package.json | jq '{name: .name, keywords: .keywords} | select(.keywords == null)' | jq .name
  #echo $lib_name
  #lib_url=$(cat cdnjs/ajax/libs/${all_lib[$a]}/package.json | jq '{name: .name, license: .license, licenses: .licenses,  repo: .repository} | select((.license == null and .licenses == null ) and .repo != null)' | jq -r .repo.url)
  #if [ $lib_name ] && [ $lib_url ]; then
  #  echo "- [ ][$lib_name]($lib_url)" >> url.json
  #fi
  echo -ne "$a\r"
done

#echo "Scanning the license info from the upsteam..."

#while read line
#do
#  curl -s https://raw.githubusercontent.com/$line/master/package.json | jq .license
#done < parsed_url.json

echo "All done!!!"
#for i in ${all_lib[@]}
#do
#  curl -s  https://raw.githubusercontent.com/cdnjs/cdnjs/master/ajax/libs/$i/package.json | jq '{name: .name, repo: .repositoiry} | select(.repositoiry == null)' 
#  curl -s  https://raw.githubusercontent.com/cdnjs/cdnjs/master/ajax/libs/$i/package.json | jq '{name: .name, repo: .repositoiry, license: .license} | select(.license == null)'
#done
