#!/usr/bin/env bash

if [ -z `which mysql` ]; then 
  echo "no mysql.  Attempting to run install_mysql.sh in this directory."
  bash install_mysql.sh
fi

if [ -z `which mysql` ]; then 
  echo "Still can't find mysql.  Please locate and run install_mysql.sh and then rerun this script."
  exit 0
fi
#just in case this is run right after RVM install...
source /etc/profile.d/rvm.sh

gem install datamapper
gem install dm-mysql-adapter
