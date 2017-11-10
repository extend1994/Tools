# parameters
# @prNum @branch/folder name @contributor
flag=1
if [ $# -lt 2 ]; then
  echo "Usage: . view.sh <prNum> <branch/folder name> [contributor]"
  flag=0
fi

if [ $flag -eq 1 ]; then
  branchExist=$(git br| grep $2)
  if [ "$branchExist" != "" ] && [ $(git rev-parse --abbrev-ref HEAD) != $2 ]; then
    echo -e "\033[33mBranch $2 exists! Now ready to checkout...\033[0m"
    git co $2
    echo -e "\033[32mCheckout to the branch $2 and update to latest status\033[0m"
    git pull git@github.com:$3/cdnjs.git  $2:$2 --rebase -f
  else
    git fetchpr $1
    git co $1
    git br -m $2
  fi

  libCheckout=$(grep $2 .git/info/sparse-checkout)
  if [ "$libCheckout" == "" ]; then
    echo "/ajax/libs/$2/*" >> .git/info/sparse-checkout
  fi
  git rsh
  #libAbsolutePath=$(readlink ~/repos/cdnjs/ajax/libs/$2/ -nf)
  ./tools/fixFormat.js
  cat ajax/libs/$2/package.json | rm ajax/libs/$2/$(jq .version -r) -rf
  cat ajax/libs/$2/package.json | echo -e "\033[33majax/libs/$2/$(jq .version -r) is removed\033[0m"
  ./auto-update.js run $2
  # clean spare files
  tree ajax/libs/$2/
  git clean -df
  cat ajax/libs/$2/package.json | git s ajax/libs/$2/$(jq .version -r)
  echo -e "\033[32mdone!\033[0m"
fi
