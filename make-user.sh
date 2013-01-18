#!/bin/bash
## First validate
#make sure there's a user ID
if [ -z $1 ]; then
 echo "You must include a user ID as the first agruement.  Example: ./make-user chrisk"
 exit 1
fi
PASSWORD=$2
if [ -z $2 ]; then
 echo "no password was set for second arguement, so I'm setting default to 'redial2013'"
 PASSWORD=redial2013
fi

NETID=$1
# Make the user.
useradd -d /home/$NETID $NETID -m
echo -e "$PASSWORD\n$PASSWORD" | (passwd $NETID)
#expire password on next user login
passwd -e

# set up folders for html and sinatra

HOME_PATH="/home/$NETID"
#does home path exist?
if [ ! -d $HOME_PATH ]; then
 echo "I can find home path $HOME_PATH for user $NETID"
 exit 1
fi

#add html directories
mkdir -p $HOME_PATH/public_html
mkdir -p $HOME_PATH/sinatra

#add Asterisk files for user
/root/scripts/make-ast-user.sh $NETID

#add sinatra app creater script to user directory
cp /root/scripts/new_sinatra_app.rb $HOME_PATH/new_sinatra_app.rb
chown $NETID $HOME_PATH/new_sinatra_app.rb
chmod 755 $HOME_PATH/new_sinatra_app.rb

#add scripts directory
#add gencallfile.rb script
#add mailer script
 
echo "$NETID is set up!  Their password is $PASSWORD.  They are forced to change it when they log in for the first time."

