#!/bin/bash
#My Lab 1.5
wget -qO- whatismypublicip.com | grep \"up_finished | awk '{print $2}' | cut -d">" -f 2
exit
