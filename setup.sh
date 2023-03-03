#!/bin/bash
source base.sh

pprint "[SETUP] Installing Docker Components..." "info"
apt-get install -y \
    docker.io \
    docker-compose \
    apparmor \
    npm
success

pprint "[SETUP] Adding $USER to docker group..." "info"
usermod -aG docker $USER
success

pprint "[SETUP] Creating .env file" "info"
sudo -u $USER cp -n example.env .env
success
pprint "[SETUP] Update .env file with your specific values" "info"
pprint "[SETUP] Reset shell to apply group changes with 'newgrp docker'!" "info"

