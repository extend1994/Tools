#!/usr/bin/env bash

# Source: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux

# Reset
Reset='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

echo -e $Reset Text Reset $Reset

echo -e $Black Black $Reset
echo -e $Red Red $Reset
echo -e $Green Green $Reset
echo -e $Yellow Yellow $Reset
echo -e $Blue Blue $Reset
echo -e $Purple Purple $Reset
echo -e $Cyan Cyan $Reset
echo -e $White White $Reset

echo -e $BBlack Black $Reset
echo -e $BRed Red $Reset
echo -e $BGreen Green $Reset
echo -e $BYellow Yellow $Reset
echo -e $BBlue Blue $Reset
echo -e $BPurple Purple $Reset
echo -e $BCyan Cyan $Reset
echo -e $BWhite White $Reset

echo -e $UBlack Black $Reset
echo -e $URed Red $Reset
echo -e $UGreen Green $Reset
echo -e $UYellow Yellow $Reset
echo -e $UBlue Blue $Reset
echo -e $UPurple Purple $Reset
echo -e $UCyan Cyan $Reset
echo -e $UWhite White $Reset

echo -e $On_Black Black $Reset
echo -e $On_Red Red $Reset
echo -e $On_Green Green $Reset
echo -e $On_Yellow Yellow $Reset
echo -e $On_Blue Blue $Reset
echo -e $On_Purple Purple $Reset
echo -e $On_Cyan Cyan $Reset
echo -e $On_White White $Reset

echo -e $IBlack Black $Reset
echo -e $IRed Red $Reset
echo -e $IGreen Green $Reset
echo -e $IYellow Yellow $Reset
echo -e $IBlue Blue $Reset
echo -e $IPurple Purple $Reset
echo -e $ICyan Cyan $Reset
echo -e $IWhite White $Reset

echo -e $BIBlack Black $Reset
echo -e $BIRed Red $Reset
echo -e $BIGreen Green $Reset
echo -e $BIYellow Yellow $Reset
echo -e $BIBlue Blue $Reset
echo -e $BIPurple Purple $Reset
echo -e $BICyan Cyan $Reset
echo -e $BIWhite White $Reset

echo -e $On_IBlack Black $Reset
echo -e $On_IRed Red $Reset
echo -e $On_IGreen Green $Reset
echo -e $On_IYellow Yellow $Reset
echo -e $On_IBlue Blue $Reset
echo -e $On_IPurple Purple $Reset
echo -e $On_ICyan Cyan $Reset
echo -e $On_IWhite White $Reset
