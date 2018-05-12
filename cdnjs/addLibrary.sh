#!/usr/bin/env bash
# @libraryName @source: git/npm @package.json url
MYPATH=$(dirname "$0")
. "$MYPATH/../ColorEchoForShell/dist/ColorEcho.bash"

if [ $# -ne 3 ]; then
  echo.Yellow "Usage: ./<path_to>/addLibrary.sh <libName> <source> <package.json url>"
else

  libName=$1
  src=$2
  url=$3

  if [ $(git rev-parse --abbrev-ref HEAD) != $1 ]; then
    echo.Yellow "Checking out new branch from master"
    git cob $libName master
  fi
  mkdir ajax/libs/$libName
  wget $url -O ajax/libs/$libName/package.json
  ./tools/fixFormat.js
  vim ajax/libs/$libName/package.json

  if [ $src == 'git' ]; then
    ./../autoupdate/autoupdate.js run $libName
  else
    ./auto-update.js run $libName
  fi

  tree ajax/libs/$libName/
  cat ajax/libs/$libName/package.json | rm -rf ajax/libs/$libName/!(package.json|$(jq .version -r))
  echo.Green "Checking everything is okay and add the files..."
  npm t && git add . && git ci && git lgs
fi
