#!/bin/bash
#Bash Assignment

function sysname ()
{
	echo ""
	hostname -s
	return 0	
}

function dname () 
{
	echo ""
	if [ -n $(hostname -d) ]; 
	then 
		echo "This computer is joined in the $(hostname -d) domain"
       	else 
		echo "This computer is not part of any domaink" 
	fi
	return 0
}

function ipaddr ()
{
	#Get all NICs but loopback
	nics=($(ip link show | grep -E "?: " | grep -v lo: | awk '{print $2}' | cut -d: -f1))
	echo ""
	for (( nnics=0; nnics < ${#nics[@]}; nnics++))
		{
			ips[$nnics]=$(ip -4 address show dev ${nics[$nnics]}  | grep inet | awk '{print $2}' | cut -d/ -f1)
		}
		for ((nicsmsg=0; nicsmsg < ${#nics[@]}; nicsmsg++))
		{
			if [ -z ${ips[$nicsmsg]} ]; then
				echo "The interface ${nics[$nicsmsg]} have no ip"
			else
				echo "The interface ${nics[$nicsmsg]} is configured with this ip ${ips[$nicsmsg]}"
			fi
		}
	
}

function osversion ()
{	
	echo ""
	echo "The OS Version of this computer is: $(cat /etc/os-release | grep -E "VERSION=" | awk -F\" '{print $2}')"
	return 0	
}

function osname ()
{
	echo ""
	echo "The OS Name of this computer is: $(cat /etc/os-release | grep -E PRETTY_NAME | awk -F\" '{print $2}')"
	return 0
}

function cpu ()
{
	echo ""
	echo "--------------------CPU description--------------------"
	echo "CPU name: $(lscpu | grep name | awk '{print $3 " " $4 " " $5 " " $6 " " $8}')"
	echo "CPU operation mode architecture: $(lscpu | grep op-mode | awk '{print $3 " " $4}')"
	echo "CPU L1d cache: $(lscpu | grep L1d | awk '{print $3}')"
	echo "CPU L1i cache: $(lscpu | grep L1i | awk '{print $3}')"
	echo "CPU L1d cache: $(lscpu | grep L2 | awk '{print $3}')"
	echo "CPU L1d cache: $(lscpu | grep L3 | awk '{print $3}')"
	return 0
}

function mem ()
{
	echo ""
	echo "Memory installed: $(free -h | grep -E Mem: | awk '{print $2}')"
	return 0
}

function disk ()
{
	echo ""
	echo "Partition Disk Space Available" | awk '{printf "%-50s %-80s\n"," "$1, $2" "$3" "$4}'
	echo "========================================================================"
	df -Th | grep ext[2-4] | awk '{printf "%-35s %-20s %-20s\n", $1, $7, $5}'
	return 0
}

function printers ()
{
	echo""
	if [ -z $(lpstat -a)];
	then
		echo "This computers has no printers"
	else
		echo " List of Printers Available"
		echo "============================"
		lpstat -a | awk '{print $1}'
	fi
	return 0
}

function softwares ()
{
	echo ""
	echo "Name Version" | awk '{printf "%-50s %-80s\n", $1, $2}'
	echo "============================================================="
	dpkg-query -l | grep ii | awk '{printf "%-50s %-80s\n", $2, $3}'| more
	return 0
}

function error ()
{

return 0
}

function schelp ()
{

return 0
}
params=1

while [ $params -le $# ]
do
	case $1 in

		-s) 	sysname
			;;

		-d)	dname
			;;

		-ip)	ipaddr
			;;
	esac
	$1
	shift
done


