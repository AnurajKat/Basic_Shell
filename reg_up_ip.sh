#!/bin/sh
if [ "$EUID" -ne 0 ]
then 
	echo "please run this as root"
	exit
fi

ip=$(curl -l  http://icanhazip.com)
oldip=$(cat /home/anuraj/newip)
if [ "$ip" !=  "$oldip" ]
then
	#echo "match"
	echo "$ip" > /home/anuraj/newip
	python3 /home/anuraj/updateip.py
	mv "/etc/nginx/conf.d/test.updater" "/etc/nginx/conf.d/test.conf"
	#rm "/etc/nginx/conf.d/test.updater"
	nginx -s reload
	if [ "$?" -ne 0 ]
	then
		echo "failed \t  $(date)" >> ip_update_log
	else
		echo "success \t  $(date)" >> ip_update_log
	fi
else
	echo "no_change \t  $(date)" >> ip_update_log
fi

