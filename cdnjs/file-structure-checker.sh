#!/usr/bin/env bash
set -e
[[ -e ~/.colorEcho ]] && . ~/.colorEcho
if [[ $# -lt 1 ]]; then
  echo.LightRed "Please enter library name"
  exit 1
fi
libName=$1
mkdir -p "/run/shm/cdnjsCheck"
for versions in $(echo $HOME/repos/cdnjs/ajax/libs/$libName/*/); do
  newerVer=$(echo $versions | cut -d '/' -f 9)
  newerfileList="/run/shm/cdnjsCheck/$(date --iso-8601)_${libName}_${newerVer}_fileList"
  cd $versions
  find . | sort > $newerfileList
  if [[ -n "$olderVer" ]] && [[ -n $(diff "$newerfileList" "$olderfileList") ]]; then
    echo.LightYellow "Found file structure change at v$newerVer!"
    echo.Yellow $(diff "$newerfileList" "$olderfileList")
  fi
  olderVer=$newerVer
  olderfileList="/run/shm/cdnjsCheck/$(date --iso-8601)_${libName}_${olderVer}_fileList"
done
