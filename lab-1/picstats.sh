#!/bin/bash
#My Lab 1.7

#Color
red=`tput setaf 1`
green=`tput setaf 2`
NC=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

#This command show the total of the regular files in the Directory ~/Pictures
totalf=`find ~/Pictures/ -maxdepth 1 -type f | awk '/\//{print ++c, $0}' | tail -n 1 | awk '{print $1}'`
echo ""
echo "The total of Files on ~/Pictures directory is of ${green}$totalf${NC} files."
echo ""

#This command will show the how much space on disk these files are using
totals=`find ~/Pictures/ -type f -print0 | du --files0-from=- -shc | tail -n1 | awk '{print $1}'`
echo "The total of disk usage of all these files is ${green}$totals${NC}"
echo ""

#This commands will show the 3 biguest regular files on ~/Pictures/
files=`find ~/Pictures/ -type f -print0 | du --files0-from=- -sh | sort -h | tail -3`
echo "The 3 biggest files is:
${green}$files${NC}"
