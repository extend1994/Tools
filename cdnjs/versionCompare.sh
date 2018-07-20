#!/usr/bin/env bash
# parameters
# @git_clone_url @npm_name
# git-ver is for git
# npm-ver is for npm
flag=1
if [ $# -lt 1 ]; then
  echo "Usage: ./<path_to>/versionCompare.sh <git_url> <npm_name>"
  flag=0
fi

if [ $flag -eq 1 ]; then
  git clone $1
  git_dir=$(echo $1 | awk '{split($1, Arr, /[/]/); print Arr[length(Arr)]}')
  cd $git_dir
  git tag > git-ver.txt
  mv git-ver.txt ../
  cd ../

  # Whether npm package name is the same as git repo
  if [ $# -eq 2 ]; then
    npm show $2 versions > npm-ver.txt
  else
    npm show $git_dir versions > npm-ver.txt
  fi

  # count lines of the result of npm show
  lines=$(wc -l npm-ver.txt | awk '{print $1}')
  # Elimate spare symbols and let the result be the same as $(git tag)
  sed -i "s/v//g" git-ver.txt
  sed -i "s/\[//g" npm-ver.txt
  sed -i "s/\]//g" npm-ver.txt

  if [ $lines != 1 ]; then
    sed -i "s/,//g" npm-ver.txt
  else
    sed -i "s/,/\n/g" npm-ver.txt
  fi

  sed -i "s/'//g" npm-ver.txt
  sed -i "s/\ //g" npm-ver.txt

  # Go compare
  git_ver_lines=$(wc -l git-ver.txt | awk '{print $1}')
  npm_ver_lines=$(wc -l npm-ver.txt | awk '{print $1}')
  if [ $git_ver_lines -ge $npm_ver_lines ]; then
    vimdiff git-ver.txt npm-ver.txt
  else
    vimdiff npm-ver.txt git-ver.txt
  fi
  # Remove all temporary files and folders.
  rm $git_dir git-ver.txt npm-ver.txt -rf
fi
