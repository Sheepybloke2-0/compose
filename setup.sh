#!/bin/bash

TAB=64
INFO=$(tput setaf 4)
SUCCESS=$(tput setaf 2)
STD=$(tput sgr0)

printf "${INFO} - Installing Docker Components...\n${STD}"
apt-get install -y \
    docker.io \
    docker-compose \
    apparmor \
    npm
printf "%${TAB}s\n" "${SUCCESS}[Done]${STD}"

printf "${INFO} - Adding $USER to docker group...\n${STD}"
usermod -aG docker $USER
printf "%${TAB}s\n" "${SUCCESS}[Done]${STD}"

printf "${INFO} - Reset shell to apply group changes with 'newgrp docker'!\n${STD}"

