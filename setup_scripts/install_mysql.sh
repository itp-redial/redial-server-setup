#/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install mysql-server mysql-client libmysqlclient-dev
echo ""
echo "Please choose a password for MySQL root, or hit Enter for no password:"
read -p "New Password > " NEW_PASS
if [ -n "$NEW_PASS" ]; then
  mysqladmin -u root password $NEW_PASS
fi

