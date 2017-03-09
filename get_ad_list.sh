#!/bin/bash

ad_list_url="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts"
ad_file="/etc/hosts"
temp_ad_file="/tmp/adlist.tmp"

curl $ad_list_url > $temp_ad_file

if [ -f "$temp_ad_file" ]
then
	sed '/# Custom host records are listed here./r custom_hosts.txt' $temp_ad_file
	mv $temp_ad_file $ad_file
else
	echo "Error building the ad list, please try again."
	exit
fi

#service dnsmasq restart
pkill -HUP dnsmasq
