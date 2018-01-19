#!/usr/bin/env bash
# parameters
# @git_clone_url @npm_name
# tmp1 is for git
# tmp2 is for npm
flag=1
if [ $# -lt 1 ]; then
  echo "Usage: ./<path_to>/versionCompare.sh <git_url> <npm_name>"
  flag=0
fi

if [ $flag -eq 1 ]; then
  git clone $1
  git_dir=$(echo $1 | awk '{split($1, Arr, /[/]/); print Arr[length(Arr)]}')
  cd $git_dir
  git tag > tmp1.txt
  mv tmp1.txt ../
  cd ../

  # Whether npm package name is the same as git repo
  if [ $# -eq 2 ]; then
    npm show $2 versions > tmp2.txt
  else
    npm show $git_dir versions > tmp2.txt
  fi

  # count lines of the result of npm show
  lines=$(wc -l tmp2.txt | awk '{print $1}')
  # Elimate spare symbols and let the result be the same as $(git tag)
  sed -i "s/v//g" tmp1.txt
  sed -i "s/\[//g" tmp2.txt
  sed -i "s/\]//g" tmp2.txt

  if [ $lines != 1 ]; then
    sed -i "s/,//g" tmp2.txt
  else
    sed -i "s/,/\n/g" tmp2.txt
  fi

  sed -i "s/'//g" tmp2.txt
  sed -i "s/\ //g" tmp2.txt

  # Go compare
  tmp1_lines=$(wc -l tmp1.txt | awk '{print $1}')
  tmp2_lines=$(wc -l tmp2.txt | awk '{print $1}')
  if [ $tmp1_lines -ge $tmp2_lines ]; then
    vimdiff tmp1.txt tmp2.txt
  else
    vimdiff tmp2.txt tmp1.txt
  fi
  # Remove all temporary files and folders.
  rm $git_dir tmp1.txt tmp2.txt -rf
fi
