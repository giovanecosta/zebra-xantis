#!/bin/bash

# Docker and Docker Compose checking and installation.
# @author Giovane Costa https://github.com/giovanecosta

echo $'Hello! I\'ll check if Docker and Docker Compose are available and try to install if not.'
echo $'If you are sure that they\'re available, you can skip this step.\n\n'

read -p  "Do you want to install Docker and Docker compose? [Y/n] " install_docker

if [ "${install_docker,}" != "n" ]; then

  if ! [ -x "$(command -v docker)" ]; then
    echo $'Docker not found. Installing...'

    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x get-docker.sh
    ./get-docker.sh
    sudo usermod -aG docker $(whoami)
    rm get-docker.sh

    echo $'Docker installed!'
  else
    echo $'Great! It seems that Docker is available!'
  fi

  if ! [ -x "$(command -v docker-compose)" ]; then
    echo $'Docker Compose not found. Installing...'

    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    echo $'Docker Compose installed!'
  else
    echo $'Great! It seems that Docker Compose is available!'
  fi

else
  echo $'Skipping Docker verification...'
fi

echo $'\nSetting Up...\n'

if [ -x "$(command -v docker-compose)" ]; then
  echo $'\nSetup finished!!\n'
  echo $'You may need to login again to use docker-compose properly\n'
  echo $'Run docker-compose up to run containers'
  echo $'\n\nBye.'
else
  echo $'Docker Compose not found. Please run script again and choose to install or install manually.'
  echo $'Read more at: https://docs.docker.com/compose/install/'

  echo $'\nSetup failed!!\n'
fi
