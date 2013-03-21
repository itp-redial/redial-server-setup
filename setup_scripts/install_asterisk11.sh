#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev linux-headers-$(uname -r) libsqlite3-dev
apt-get -y install git-core subversion
apt-get -y install libiksemel-dev
apt-get -y install speex libspeex-dev libspeexdsp-dev libvorbis-dev libssl-dev sox openssl mpg123 libmpg123-0
apt-get -y install liblua5.1-dev lua5.1
apt-get -y install libneon27-dev libical-dev
apt-get -y install libgmime-2.6-dev
apt-get -y install libsrtp-dev
apt-get -y install curl libcurl4-openssl-dev
#if you want to send email from asterisk...
apt-get -y install sendmail
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-11-current.tar.gz
tar -xzf asterisk-11-current.tar.gz
cd asterisk-11*
contrib/scripts/get_mp3_source.sh
./configure
# make menuselect
make
make install
make samples
#set up service
cp contrib/init.d/rc.debian.asterisk /etc/init.d/asterisk
sed -e 's/__ASTERISK_SBIN_DIR__/\/usr\/sbin/g' -e 's/__ASTERISK_VARRUN_DIR__/\/var\/run\/asterisk\//g' -e 's/__ASTERISK_ETC_DIR__/\/etc\/asterisk\//g' -i /etc/init.d/asterisk
#prep asterisk for multiple users
touch /etc/asterisk/userconf_extensions.conf
echo "#include /etc/asterisk/userconf_extensions.conf" >> /etc/asterisk/extensions.conf
touch /etc/asterisk/userconf_sip.conf
echo "#include /etc/asterisk/userconf_sip.conf" >> /etc/asterisk/sip.conf
touch /etc/asterisk/userconf_iax.conf
echo "#include /etc/asterisk/userconf_iax.conf" >> /etc/asterisk/iax.conf
touch /etc/asterisk/userconf_voicemail.conf
echo "#include /etc/asterisk/userconf_voicemail.conf" >> /etc/asterisk/voicemail.conf
touch /etc/asterisk/userconf_musiconhold.conf
echo "#include /etc/asterisk/userconf_musiconhold.conf" >> /etc/asterisk/musiconhold.conf
asterisk -rx "module reload"
sed -e 's/;\[files\]/\[files\]/g' -i /etc/asterisk/asterisk.conf
sed -e 's/;astctlpermissions = 0660/astctlpermissions = 0770/g' -i /etc/asterisk/asterisk.conf 
sed -e 's/;astctlgroup = apache/astctlgroup = asterisk/g' -i /etc/asterisk/asterisk.conf
service asterisk start
chmod 777 /var/spool/asterisk/outgoing
AST_ON=`asterisk -rx 'core show calls'`
if [ -n "$AST_ON" ];then echo "Asterisk is running."; fi
if [ -z "$AST_ON" ];then echo "Asterisk is NOT running.  Something seems to have gone wrong with the install."; fi
