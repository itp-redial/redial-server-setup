cd ~
mkdir -p ~/node_workspace
npm install -g sm
git clone https://github.com/ajaxorg/cloud9.git cloud9
cd cloud9
sm install
cat << EOF
***********************
Run Cloud9 at least once like this (change the username and password):
  bin/cloud9.sh -w ~/node_workspace/ -l 0.0.0.0 --username yourname --password yourpassword

You should be able to access the IDE from any broswer by going to this URL:
  http://YOUR.SERVER.IP:3131/

If you want to run Cloud9 as a background process, I would recommend installing Forever, if it's not installed already:
  npm install forever -g
  cd ~/cloud9
  forever start server.js -w ~/node_workspace/ -a x-www-browser -l 0.0.0.0 --username yourname --password yourpassword
***********************
EOF
