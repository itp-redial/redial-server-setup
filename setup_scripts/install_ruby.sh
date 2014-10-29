#!/usr/bin/env bash

#get yaml libs
apt-get -y install libyaml-dev
#install ruby rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -L https://get.rvm.io | sudo bash -s stable --autolibs=enabled
source /etc/profile.d/rvm.sh
rvm install 2.0.0
rvm rubygems current
rvm use 2.0.0 --default
# create symbolic link to /usr/bin/ruby for legacy compatibility
ln -s `which ruby` /usr/bin/ruby
source /etc/profile.d/rvm.sh
