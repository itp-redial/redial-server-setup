#!/bin/bash
## First validate
#make sure there's a user ID
if [ -z $1 ]; then
 echo "You must include a user ID as the first agruement.  Example: ./make-ast-user chrisk"
 exit 1
fi

NETID=$1
HOME_PATH="/home/$NETID"
#does home path exist?
if [ ! -d $HOME_PATH ]; then
 echo "I can find home path $HOME_PATH for user $NETID"
 exit 1
fi

#add user to asterisk group
usermod -a -G asterisk $NETID

# set up home directory
mkdir -p  $HOME_PATH/asterisk_conf
mkdir -p  $HOME_PATH/asterisk_sounds
mkdir -p  $HOME_PATH/asterisk_agi

chown $NETID $HOME_PATH/asterisk_*
chgrp asterisk $HOME_PATH/asterisk_*
chmod 775 $HOME_PATH/asterisk_sounds

touch $HOME_PATH/asterisk_conf/extensions.conf
touch $HOME_PATH/asterisk_conf/sip.conf
touch $HOME_PATH/asterisk_conf/iax.conf
touch $HOME_PATH/asterisk_conf/voicemail.conf
touch $HOME_PATH/asterisk_conf/musiconhold.conf
chown "$NETID":asterisk $HOME_PATH/asterisk_conf/*.conf

# set up configs
echo "#include \"$HOME_PATH/asterisk_conf/extensions.conf\"" >>  /etc/asterisk/userconf_extensions.conf
echo "#include \"$HOME_PATH/asterisk_conf/sip.conf\"" >> /etc/asterisk/userconf_sip.conf
echo "#include \"$HOME_PATH/asterisk_conf/iax.conf\"" >>  /etc/asterisk/userconf_iax.conf
echo "#include \"$HOME_PATH/asterisk_conf/voicemail.conf\"" >>  /etc/asterisk/userconf_voicemail.conf
echo "#include \"$HOME_PATH/asterisk_conf/musiconhold.conf\"" >>  /etc/asterisk/userconf_musiconhold.conf
ls -al $HOME_PATH/asterisk_conf
echo "confirm that user is added to asterisk group:"
groups $NETID
echo ""
echo "Asterisk is set up for user $NETID.  You will need to manually add an extension for"
echo "this user to /etc/asterisk/userconf_extensions.conf"
exit 0
