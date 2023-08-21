#!/bin/bash

i3ConfigurationPath="/$HOME/.config/i3"
i3StatusConfigurationPath="/$HOME/.config/i3/i3status"

if [[ -d "$i3ConfigurationPath" ]]; then
	echo "I will move the i3 configuration too the needed location."
	cp config $i3ConfigurationPath/config
	echo "Done"
else 
	echo "The Path $i3ConfigurationPath doesent exist. Will create it now."
	mkdir $i3ConfigurationPath && cp config $i3ConfigurationPath/config
	echo "Done"
fi

if [[ -d "$i3StatusConfigurationPath" ]]; then
	echo "I will move the i3status configuration too the needed location."
	cp -r i3status/i3status.conf $i3StatusConfigurationPath/i3status.conf
	echo "Done"
else 
	echo "The Path $i3StatusConfigurationPath doesent exist. Will create it now."
	mkdir $i3StatusConfigurationPath && cp -r i3status/i3status.conf $i3StatusConfigurationPath/i3status.conf
	echo "Done"
fi
