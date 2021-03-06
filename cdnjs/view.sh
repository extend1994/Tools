#!/usr/bin/env bash
# parameters
# @prNum @lib_name @commit_nbr @branch_name @contributor
MYPATH=$(dirname "$0")
. "$MYPATH/../ColorEchoForShell/dist/ColorEcho.bash"

flag=1
if [ $# -lt 2 ]; then
  echo "Usage: ./<path_to>/view.sh <prNum> <lib_name> <commit_nbr> [branch_name] [contributor]"
  flag=0
fi

prNum=$1
lib_name=$2
branch=$2
commit_nbr=$3
contributor=$5

if [ $flag -eq 1 ];then
  echo.BoldCyan "Checking if cdnjs has hosted the requested library"
  curl -s "https://api.cdnjs.com/libraries?search=$lib_name&fields=name" | jq '.[]'
  echo.BoldYellow "Enter 1 to continue or 0 to break"
  read flag
fi

if [ $# -ge 4 ] && [ $branch != $4 ]; then
  branch=$4
fi
if [ $flag -eq 1 ]; then
  if [ -n "$(git br --list $branch)" ] && [ $(git rev-parse --abbrev-ref HEAD) != $branch ]; then
    echo.BoldYellow "Branch $branch exists! Now ready to checkout..."
    git co $branch
    echo.Green "Checkout to the branch $branch and update to latest status"
    git pull git@github.com:$contributor/cdnjs.git  $branch:$branch --rebase -f
  elif [ $(git rev-parse --abbrev-ref HEAD) == $branch ]; then
    echo.Green "Already on the branch! Continue to review..."
  else
    git fetchpr $prNum
    git co $prNum
    git br -m $branch
  fi

  libCheckout=$(grep $lib_name -w .git/info/sparse-checkout)
  if [ "$libCheckout" == "" ]; then
    echo "/ajax/libs/$lib_name/*" >> .git/info/sparse-checkout
  fi
  git rsh

  relative_min=$(git show -s --format=%cr HEAD~$commit_nbr | grep min)
  relative_hour=$(git show -s --format=%cr HEAD~$commit_nbr | grep hour)
  #if [ "$relative_min" == "" ] && [ "$relative_hour" == "" ]; then
  #  git pull origin master:master --rebase
  #fi

  #libAbsolutePath=$(readlink ~/repos/cdnjs/ajax/libs/$2/ -nf)
  ./tools/fixFormat.js
  cat ajax/libs/$lib_name/package.json | rm ajax/libs/$lib_name/$(jq .version -r) -rf
  cat ajax/libs/$lib_name/package.json | echo.Orange "ajax/libs/$lib_name/$(jq .version -r) is removed"

  # Check source is npm or git repo
  source=$(git log -$commit_nbr | grep npm)
  if [ -n "$source" ]; then
    ./auto-update.js run $lib_name
  else
    ./../autoupdate/autoupdate.js run $lib_name
  fi

  # clean spare files
  tree ajax/libs/$lib_name/
  git clean -df
  cat ajax/libs/$lib_name/package.json | git s ajax/libs/$lib_name/$(jq .version -r)
  echo.BoldGreen "All done!"
fi
