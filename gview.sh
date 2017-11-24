# parameters
# @prNum @branch/folder name @contributor
flag=1 # Determine the shell script is used correctly
if [ $# -lt 2 ]; then
  echo "Usage: . gview.sh <prNum> <branch/folder name> [contributor]"
  flag=0
fi

if [ $flag -eq 1 ]; then

  if [ $(git br --list $2) ] && [ $(git rev-parse --abbrev-ref HEAD) != $2 ]; then
    echo -e "\033[33mBranch $2 exists! Now ready to checkout...\033[0m"
    git co $2
    echo -e "\033[32mCheckout to the branch $2 and update the latest status.\033[0m"
    git pull git@github.com:$3/cdnjs.git  $2:$2 --rebase -f
  else
    git fetchpr $1
    git co $1
    git br -m $2
  fi

  libCheckout=$(grep $2 -w .git/info/sparse-checkout)
  if [ "$libCheckout" == "" ]; then
    echo "/ajax/libs/$2/*" >> .git/info/sparse-checkout
  fi
  git rsh
  git pom
  #libAbsolutePath=$(readlink ~/repos/cdnjs/ajax/libs/$2/ -nf)
  ./tools/fixFormat.js
  echo "fixed"
  cat ajax/libs/$2/package.json | rm ajax/libs/$2/$(jq .version -r) -rf
  cat ajax/libs/$2/package.json | echo -e "\033[33majax/libs/$2/$(jq .version -r) is removed\033[0m"
  ./../autoupdate/autoupdate.js run $2
  tree ajax/libs/$2
  # clean spare files
  git clean -df
  cat ajax/libs/$2/package.json | git s ajax/libs/$2/$(jq .version -r)
  echo -e "\033[32mdone!\033[0m"
fi
