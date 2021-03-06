#!/usr/bin/env bash

#install dependencies
apt-get -y install libcurl4-openssl-dev
#run just in case rvm was installed in this session
source /etc/profile
#increase disk swap space
sudo dd if=/dev/zero of=/swap bs=1M count=1024
mkswap /swap
swapon /swap

#install passenger and nginx
export rvmsudo_secure_path=1
rvmsudo gem install passenger
rvmsudo passenger-install-nginx-module --auto --prefix=/opt/nginx --auto-download --extra-configure-flags=none --languages ruby,python,nodejs

#install sinatra
gem install sinatra --no-ri --no-rdoc
gem install haml --no-ri --no-rdoc

#replace nginx.conf
mv /opt/nginx/conf/nginx.conf /opt/nginx/conf/nginx_old.conf
cp -f ~/redial-server-setup/setup_scripts/nginx.conf /opt/nginx/conf/nginx.conf

#set up nginx as a service and start
wget -O init-deb.sh http://www.linode.com/docs/assets/1139-init-deb.sh
mv init-deb.sh /etc/init.d/nginx
chmod +x /etc/init.d/nginx
/usr/sbin/update-rc.d -f nginx defaults
service nginx start
