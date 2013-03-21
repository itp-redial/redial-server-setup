#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install python-software-properties python g++ make
yes | add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get -y install nodejs
#apt-get -y install npm
#apt-get -y install nodejs-dev
export NODE_PATH=/usr/lib/node_modules/
echo "export NODE_PATH=$NODE_PATH" >> ~/.bashrc
npm cache clear
