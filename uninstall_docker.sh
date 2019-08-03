#!/bin/bash

read -p  "Do you want to REMOVE Docker and Docker compose? [y/N] " uninstall_docker

if [ "${uninstall_docker,}" == "y" ]; then

  read -p  "WARNING This script will COMPLETELY remove docker and docker-compose. Do you really want to procced? [y/N] " really_uninstall_docker

  if [ "${really_uninstall_docker,}" == "y" ]; then

    if [ -x "$(command -v docker)" ]; then
      echo $'Removing Docker...'

      sudo apt-get purge docker-ce docker-ce-cli
      sudo rm -rf /var/lib/docker

      echo $'Docker removed!'
    else
      echo $'Oh, Docker not found! Nothing to do here...'
    fi

    if [ -x "$(command -v docker-compose)" ]; then
      echo $'Removing Docker Compose...'

      sudo rm /usr/local/bin/docker-compose

      echo $'Docker Compose removed!'
    else
      echo $'Oh, Docker Compose not found! Nothing to do here...'
    fi
  else
    echo $'I knew it! Saved by the bell ^^\''
  fi
else
  echo $'Ok. Bye!'
fi
