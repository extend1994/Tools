#!/usr/bin/env bash
# @libraryName @source: git/npm @package.json url
MYPATH=$(dirname "$0")
. "$MYPATH/../ColorEchoForShell/dist/ColorEcho.bash"

flag=1
if [ $# -ne 3 ]; then
  echo "Usage: ./<path_to>/addLibrary.sh <libName> <source> <package.json url>"
  flag=0
fi

if [ $flag -eq 1 ]; then
  if [ $(git rev-parse --abbrev-ref HEAD) != $1 ]; then
    echo.Yellow "Checking out new branch from master"
    git cob $1 master
  fi
  mkdir ajax/libs/$1
  wget $3 -O ajax/libs/$1/package.json
  ./tools/fixFormat.js
  vim ajax/libs/$1/package.json

  if [ $2 == 'git' ]; then
    ./../autoupdate/autoupdate.js run $1
  else
    ./auto-update.js run $1
  fi

  tree ajax/libs/$1/
  cat ajax/libs/$1/package.json | rm ajax/libs/$1/!(package.json|$(jq .version -r)) -rf
  echo.Green "Checking everything is okay and add the files..."
  npm t && git add . && git ci && git lgs
fi
