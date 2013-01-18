apt-get update
apt-get -y install build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev inux-headers-$(uname -r) libsqlite3-dev
apt-get -y install git-core subversion
apt-get -y install mysql-server mysql-client libmysql-ruby libmysqlclient-dev
apt-get -y install libiksemel-dev
apt-get -y install speex libspeex-dev libspeexdsp-dev libvorbis-dev libssl-dev sox openssl mpg123 libmpg123-0
apt-get -y install liblua5.1-dev lua5.1
apt-get -y install libneon27-dev libical-dev
apt-get -y install libgmime-2.6-dev
apt-get -y install libsrtp-dev
apt-get -y install curl libcurl4-openssl-dev
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
service asterisk start
