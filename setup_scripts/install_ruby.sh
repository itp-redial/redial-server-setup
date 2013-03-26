#!/usr/bin/env bash

#get yaml libs
apt-get -y install libyaml-dev
#install ruby rvm
\curl -L https://get.rvm.io | sudo bash -s stable --autolibs=enabled
source /etc/profile.d/rvm.sh
rvm install 1.9.3-p392
rvm rubygems current
rvm use 1.9.3 --default
# create symbolic link to /usr/bin/ruby for legacy compatibility
ln -s `which ruby` /usr/bin/ruby
source /etc/profile.d/rvm.sh
