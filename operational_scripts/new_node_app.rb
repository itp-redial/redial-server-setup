#!/usr/bin/env ruby

require 'fileutils'
public_ip=File.open("/etc/publicIP",'r').read
called_from = File.expand_path(File.dirname("."))
nid = called_from.split("/")[2]

install_root = "/home/#{nid}/node"


if !ARGV[0]
  puts "ERROR: You must supply the name of the app you want to create. Like this:"
  puts "ruby new_node_app.rb my_app" 
  exit 1
end

app_name = ARGV[0].dup
app_name.gsub!(" ", "_")

puts "Creating new app: #{app_name}..."
puts "install_root: #{install_root}"
puts "NETID: #{nid}"
puts
puts

puts "Creating folder structure..."
puts
puts "creating public directory"
# create folder structure + always_retart.txt
FileUtils.mkdir_p "#{install_root}/#{app_name}/public"

puts "creating tmp directory"
FileUtils.mkdir_p "#{install_root}/#{app_name}/tmp"

puts "creating views directory"
FileUtils.mkdir_p "#{install_root}/#{app_name}/views"

puts "creating routes directory"
FileUtils.mkdir_p "#{install_root}/#{app_name}/routes"

puts "creating restart.txt "
FileUtils.touch "#{install_root}/#{app_name}/tmp/restart.txt"

puts "creating app.js"
# populate default app
File.open("#{install_root}/#{app_name}/app.js", "w") do |f|
f.write <<-BLAH
var express = require('express');
var path = require('path');
var app = express();

app.use(express.static(path.join(__dirname, 'public')));

//middleware to handle multiple users on same box at /~netid/node/nodeappname
app.use(function(req, res, next) {
    req.url = req.url.replace(/^\\/~\\S*\\/node\\/[^\\/]+(\\/|$)/,"/");
    next();
});

app.get ('/', function(req, res){
	var name = req.param("yourname") || ""
	res.send("Hello "+ name);	
});

app.set('port', process.env.PORT || 3000);
var server = app.listen(app.get('port'));
module.exports = app;

BLAH
end

puts "giving you ownership"
FileUtils.chown_R nid, "users", "/home/#{nid}/node"
puts "installing express"
output = `(cd #{install_root}/#{app_name}/ && npm install express)`
puts
puts "done!"
puts "edit your new app here:"
puts "#{install_root}/#{app_name}/"
puts "and see it on the web here:"
puts "http://#{public_ip.strip}/~#{nid}/node/#{app_name}"
