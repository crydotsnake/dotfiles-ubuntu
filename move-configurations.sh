#!/bin/bash

currentUser=$USER
i3ConfigurationPath="/home/$currentUser/.config/i3"
i3StatusConfigurationPath="/home/$currentUser/.config/i3/i3status"

if [[ -d "$i3ConfigurationPath" ]]; then
	echo "I will move the i3 configuration too the needed location."
	cp config $i3ConfigurationPath/config
	echo "Done"
else 
	echo "The Path $i3ConfigurationPath doesent exist. Will create it now."
	mkdir $i3ConfigurationPath
	cp config $i3ConfigurationPath/config
	echo "Done"
fi

if [[ -d "$i3StatusConfigurationPath" ]]; then
	echo "I will move the i3status configuration too the needed location."
	cp i3status/i3status.conf $i3StatusConfigurationPath/i3status.conf
	echo "Done"
else 
	echo "The Path $i3StatusConfigurationPath doesent exist. Will create it now."
	mdkir $i3StatusConfigurationPath
	cp i3status/i3status.conf $i3StatusConfigurationPath/i3status.conf
	echo "Done"
fi