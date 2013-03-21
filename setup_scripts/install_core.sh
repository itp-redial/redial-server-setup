#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y upgrade
apt-get -y install build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev linux-headers-$(uname -r)
apt-get -y install git-core subversion
apt-get -y install xml2

#set timezone
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
#set default shell to bash
sed -e 's/SHELL=\/bin\/sh/SHELL=\/bin\/bash/g' -i /etc/default/useradd

#copy public IP address to file /etc/publicIP
export PUBLIC_IP=`curl http://checkip.dyndns.org/ | grep -o  "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"`
echo $PUBLIC_IP > /etc/publicIP
#install scripts from git
cd /root
git clone https://github.com/itp-redial/redial-server-setup.git
echo "Rebooting your computer... Please wait 5 minutes for reboot to complete" 
sleep 5
reboot
