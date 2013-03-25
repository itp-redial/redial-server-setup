#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

#install http server
apt-get -y install apache2
apt-get -y install php5
wget http://www.itp-redial.com/class/wp-content/uploads/2012/03/httpd.conf_.txt -O /etc/apache2/httpd.conf
#cp /usr/share/doc/apache2.2-common/examples/apache2/extra/httpd-userdir.conf /etc/apache2/httpd.conf
a2enmod userdir
service apache2 restart

#just in case this is run right after RVM install...
source /etc/profile.d/rvm.sh

#install sinatra
gem install sinatra
gem install haml

#install passenger so sinatra can be run in apache
apt-get -y install libcurl4-openssl-dev
apt-get -y install apache2-prefork-dev
apt-get -y install libapr1-dev
apt-get -y install libaprutil1-dev
#apt-get -y install libapache2-mod-passenger
gem install passenger
passenger-install-apache2-module -a
#sed -i 's/ 00:00:00.000000000Z//' /var/lib/gems/1.8/specifications/*
echo "LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p392/gems/passenger-3.0.19/ext/apache2/mod_passenger.so" >> /etc/apache2/httpd.conf
echo "PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p392/gems/passenger-3.0.19" >> /etc/apache2/httpd.conf
echo "PassengerRuby /usr/local/rvm/wrappers/ruby-1.9.3-p392/ruby" >> /etc/apache2/httpd.conf

service apache2 restart
