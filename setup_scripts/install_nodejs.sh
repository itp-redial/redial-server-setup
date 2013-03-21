#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install python-software-properties python g++ make
#yes | add-apt-repository ppa:chris-lea/node.js
#install node 0.8.x, not 0.10.x
yes | add-apt-repository ppa:chris-lea/node.js-legacy
apt-get update
apt-get -y install nodejs
#apt-get -y install npm
#apt-get -y install nodejs-dev
export NODE_PATH=/usr/lib/node_modules/
echo "export NODE_PATH=$NODE_PATH" >> ~/.bashrc
npm cache clear
