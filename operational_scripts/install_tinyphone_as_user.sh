#!/bin/bash

cd ~
git clone git://github.com/itp-redial/tinyphone
cd tinyphone/tinyphone_server/
npm install socket.io
cat << EOF
*********************
TinyPhone server is now installed.
Please change the config.json file to different ports, and set any unused connectors to false.
  cd ~/tinyphone/tinyphone_server
  nano config.json

You can run tinyphone_server as a foreground process with node.
  cd ~/tinyphone/tinyphone_server
  node tinyphone_server.js

The server will stop if the terminal window is closed.
*********************
EOF
