#!/usr/bin/env bash

# Get the absolute path of the called script
THIS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Get the relative path of the called script to the current directory
REL_PATH=$(dirname "$0")

# Confirm the executor of the script is sudoer
if [[ $EUID -ne 0 ]]; then
  echo "This script should be run using sudo or as the root user"
  exit 1
fi

# Get the number of CPU
NUM_CORES=$(grep -c ^processor /proc/cpuinfo)

# if else in one line (ternary operator
a=1
b=2
[[ ${a} > ${b} ]] && echo "a > b" || echo "b >= a"

# Sync time
sudo hwclock | awk '{print $1" "$2" "$3" "$4" "$5" "$6" "$7}' | xargs -i sudo date -s {}

# csv viewer with aligned data
cat "${csvFile}" | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S
