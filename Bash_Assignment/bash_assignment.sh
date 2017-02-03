#!/bin/bash
#Bash Assignment
sysname=""
domainname=""
ipaddr=""
osname=""
cpudes=""
mem=$(free -h | grep Mem | awk '{print $2}')
disk=$(df -h | grep $(cat /etc/fstab | grep ^/ | grep 'ext' | awk '{print $1}') | awk '{print $4}')
printers=$(lpstat -p)
softwares=""

echo $mem
