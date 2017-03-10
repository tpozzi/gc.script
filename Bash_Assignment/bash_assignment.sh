#!/bin/bash
#Bash Assignment

function sysname ()
{
	echo ""
	echo "My System name is: $(hostname -s)"
	return 0
}

function dname ()
{
	echo ""
	if [ -n $(hostname -d) ];
	then
		echo "This computer is joined in the $(hostname -d) domain"
  else
		echo "This computer is not part of any domain"
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
	if [ -e /etc/os-release ]
	then
		echo "The OS Version of this computer is: $(cat /etc/os-release | grep -E "VERSION=" | awk -F\" '{print $2}')"
		return 0
	else
		echo "The file /etc/os-release was deleted or non existent.
		Is not possible determine the OS version of this Machine"

	fi
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
	if [ $(cat /etc/os-release | grep ID_LIKE | cut -d= -f2) != "debian" ]
	then
		echo ""
		echo "This option just can run in a Debian based distribution." >&2
		exit 1
	else
		if [ -z $(dpkg-query -l | grep ii | awk '{print $2}' | grep -E "^cups" | head -n1) ]
		then
			echo "This computer don't have cups installed" >&2
			echo "Please install cups to run this option" >&2
			return 1
		else
			if [ -z "$(lpstat -a)" ]
			then
				echo ""
				echo "This computers has no printers"
			else
				echo ""
				echo " List of Printers Available"
				echo "============================"
				lpstat -a | awk '{print $1}'
			fi
		fi
	fi
	return 0
}

function softwares ()
{
	#Check if the script is runing in a Linux base on Debian distribution.
	if [ $(cat /etc/os-release | grep ID_LIKE | cut -d= -f2) != "debian" ]
	then
		echo ""
		echo "This option just can run in a Debian based distribution." >&2
		exit 1
	else
		echo ""
		echo "Name Version" | awk '{printf "%-50s %-80s\n", $1, $2}'
		echo "============================================================="
		dpkg-query -l | grep ii | awk '{printf "%-50s %-80s\n", $2, $3}'| more
		return 0
	fi
}

function error ()
{
		errorcheck="no"
		params=0
		while [ $params -lt ${#arg[@]} ]; do
		case ${arg[$params]} in

				-s)					errorcheck="ok"
										#sysname
				;;

				-dn)				errorcheck="ok"
										#dname
				;;

				-ip)				errorcheck="ok"
										#ipaddr
				;;

				-osv)				errorcheck="ok"
										#osversion
				;;

				-osn)				errorcheck="ok"
										#osname
				;;

				-c)					errorcheck="ok"
										#cpu
				;;

				-m)					errorcheck="ok"
										#mem
				;;

				-d)					errorcheck="ok"
										#disk
				;;

				-p)					errorcheck="ok"
										#printers
				;;

				-soft)			errorcheck="ok"
										#softwares
				;;

				-h|--help)	errorcheck="ok"
										#schelp
				;;

				*)					echo ""
										echo "$0: invalid option ${arg[$params]}" >&2
										echo " Try $0 -h or --help" >&2
										echo ""
										exit 1
				;;
		esac
		params=$((params+1))
		#statements
	done

	if [ $errorcheck = "ok" ];
	then
		params=0
		while [ $params -lt ${#arg[@]} ]; do
			case ${arg[$params]} in

				-s)					sysname
				;;

				-dn)				dname
				;;

				-ip)				ipaddr
				;;

				-osv)				osversion
				;;

				-osn)				osname
				;;

				-c)					cpu
				;;

				-m)					mem
				;;

				-d)					disk
				;;

				-p)					printers
				;;

				-soft)			softwares
				;;

				-h|--help)	schelp
				;;
			esac
			params=$((params+1))
			#statements
		done
		echo ""
	else
		echo ""
		echo " Try $0 -h or --help" >&2
		echo ""
		exit 1
	fi
	return 0
}

function schelp ()
{
	echo ""
	echo "                         HELP                                "
	echo "============================================================="
	echo "Warning: This script just work on Debian based distribution."
	echo ""
	echo "This script show some hardware and system configurations."
	echo ""
	echo "Usage:"
	echo "	$0 [options]"
	echo ""
	echo "Options:"
	echo "-s show system name" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4}'
	echo "-dn show domain name" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4}'
	echo "-ip	show ip address" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4}'
	echo "-osv show OS version" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4}'
	echo "-osn show OS name" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4}'
	echo "-c show CPU description" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4}'
	echo "-m show total of memory istalled in the system" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9}'
	echo "-d show free disk available for each partition" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4" " $5 " " $6 " " $7 " " $8}'
	echo "-p show a list of printers installed in the system" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4" " $5 " " $6 " " $7 " " $8 " " $9 " " $10}'
	echo "-soft show a list of softwares installed in the system" | awk '{printf "%-64s %-5s\n", "	"$1, $2 " " $3 " " $4" " $5 " " $6 " " $7 " " $8 " " $9 " " $10}'
	echo "-h, --help show this help" | awk '{printf "%-63s %-5s\n", "	"$1 " " $2, " " $3 " " $4 " " $5}'
	echo ""
	exit 0
}
arg=($@)
error
