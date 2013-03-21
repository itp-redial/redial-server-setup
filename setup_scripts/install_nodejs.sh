#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install python-software-properties python g++ make
yes | add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get -y install nodejs
#apt-get -y install npm
#apt-get -y install nodejs-dev
