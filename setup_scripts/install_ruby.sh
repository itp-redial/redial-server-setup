#!/usr/bin/env bash

#get yaml libs
apt-get -y install libyaml-dev
#install ruby rvm
\curl -L https://get.rvm.io | sudo bash -s stable --autolibs=enabled
source /etc/profile.d/rvm.sh
rvm install 2.0.0-p481
rvm rubygems current
rvm use 2.0.0 --default
# create symbolic link to /usr/bin/ruby for legacy compatibility
ln -s `which ruby` /usr/bin/ruby
source /etc/profile.d/rvm.sh
