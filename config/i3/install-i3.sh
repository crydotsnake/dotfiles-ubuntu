#!/bin/bash

echo "Install custom packages for i3"
sudo apt install terminator feh arandr pasystray rofi lxappearance -y

printf "Do you want continue with the i3 installation? (Y/N)"
read i3InstallChoice

if [[ "$i3InstallChoice" != "${i3InstallChoice#[Yy]}" ]]; then
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
	sudo apt install ./keyring.deb
	echo "deb [arch="$(dpkg --print-architecture)"] http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) jammy" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt update
	sudo apt install i3 -y
else
	echo "Continue"
fi

printf "Do you want too move the i3 configuration? (Y/N)"
read i3ConfigurationChoice
if [[ "$i3ConfigurationChoice" != "${i3ConfigurationChoice#[Yy]}" ]]; then
	bash move-configurations.sh
else
	echo "Abort"
fi
