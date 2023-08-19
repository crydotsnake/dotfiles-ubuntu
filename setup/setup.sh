#!/bin/bash
echo "Install base packages"
sudo -s

apt install mkcert ca-certificates curl gnupg apt-transport-https git -y

echo "Add PHP repository"
add-apt-repository ppa:ondrej/php

echo "Install PHP 8.2 packages"
apt install \
	php8.2 \
	php8.2-fpm \
	php8.2-mbstring \
	php8.2-xml \
	php8.2-curl \
	php8.2-gd \
	php8.2-vips \
	php8.2-mysql \
	php8.2-igbinary \
	php8.2-intl \
	php8.2-pgsql \
	-y

echo "Install PHP 8.1 packages"
apt install \
	php8.1 \
	php8.1-fpm \
	php8.1-mbstring \
	php8.1-xml \
	php8.1-curl \
	php8.1-gd \
	php8.1-vips \
	php8.1-mysql \
	php8.1-igbinary \
	php8.1-intl \
	-y

echo "Install PHP 7.4 packages"

apt install \
	php7.4 \
	php7.4-fpm \
	php7.4-mbstring \
	php7.4-xml \
	php7.4-curl \
	php7.4-gd \
	php7.4-vips \
	php7.4-mysql \
	php7.4-igbinary \
	php7.4-intl \
	-y



printf "Should we continue with installing docker? (Y/N)"
read installDockerChoice

if [[ "$installDockerChoice" != "${installDockerChoice#[Yy]}" ]]; then

	echo "(1) Make sure default docker packages are removed"
	for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done

	echo "(2) Add Docker's official GPG Key"
	install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	chmod a+r /etc/apt/keyrings/docker.gpg

	echo "(3) Set up docker repsitory"
	echo \
	  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	  "$(. /etc/os-release && echo "$UBUNTU_CODENAME")" stable" | \
	  tee /etc/apt/sources.list.d/docker.list > /dev/null

	echo "(4) Install Docker engine"
	apt install \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin

	echo "(5) Post installation steps"
	groupadd docker && usermod -aG docker $USER && newgrp docker && docker run hello-world

	echo "(6) Start docker on boot"
	systemctl enable docker.service
	systemctl enable containerd.service
else
	echo "Abort"
fi

printf "Do you want to configure git? (Y/N)"
read configureGitChoice

if [[ "$configureGitChoice" != "${configureGitChoice#[Yy]}" ]]; then
	printf "Whats your name?"
	read gitUsername
	git config --global user.name "$gitUsername"

	printf "Whats your email?"
	read gitEmail
	git config --global user.email "$gitEmail"

	git config --global init.defaultBranch main
else
	echo "Abort"
fi