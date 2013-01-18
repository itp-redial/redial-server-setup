#!/usr/bin/env ruby

require 'fileutils'
public_ip=File.open("/etc/publicIP",'r').read
called_from = File.expand_path(File.dirname("."))
nid = called_from.split("/")[2]

install_root = "/home/#{nid}/sinatra"


if !ARGV[0]
  puts "ERROR: You must supply the name of the app you want to create. Like this:"
  puts "ruby new_sinatra_app.rb my_app" 
  exit 1
end

app_name = ARGV[0]
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

puts "creating always_restart.txt "
FileUtils.touch "#{install_root}/#{app_name}/tmp/always_restart.txt"

puts "creating config.ru"
# install config.ru
File.open("#{install_root}/#{app_name}/config.ru", "w") do |f|

f.write <<-BLAH
require File.dirname(__FILE__) + '/app.rb'

before do 
  s = request.path_info
  s[/^\\/~(\\w)+\\/sinatra\\/[^\\/|?]+/i] = ""
  request.path_info = s
end

run Sinatra::Application
BLAH
end  

puts "creating .htaccess file"  
# install .htaccess
File.open("#{install_root}/#{app_name}/.htaccess", "w") do |f|
f.write <<-BLAH
PassengerEnabled on
RackBaseURI /sinatra
PassengerAppRoot #{install_root}/#{app_name}
RackEnv development
BLAH
end
  

puts
puts "creating app.rb"
# populate default app
File.open("#{install_root}/#{app_name}/app.rb", "w") do |f|
f.write <<-BLAH
require 'sinatra'

# Main route  - this is the form where we take the input
get '/' do
  # params[:yourname] will be replaced with the value entered for 
  # the input with name 'yourname'  
  "Hello \#{params[:yourname]}"
end
BLAH
end

puts "creating simple example form"
File.open("#{install_root}/#{app_name}/public/simple_form.html", "w") do |f|
f.write <<-BLAH
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Form Example</title>
    <style type="text/css">
      body {
        width: 820px;
      }
      h1 {
        color: #555;
        border-bottom: 1px solid #ccc;
      }
      p {
        color: #121212;
        font: normal 14px/16px Helvetica, sans-serif;
      }
      input[type="text"] {
        padding: 5px;
        font: normal 14px/16px Helveticam sans-serif;
        color: #555;
      }
    </style>
  </head>
 
  <body>
      <h1>Simple form</h1>
      <p>This is a simple form example.</p>
      <form action="http://itp.nyu.edu/~#{nid}/sinatra/#{app_name}" method="GET">
        <p><label>Please enter your name:</label> <input type="text" name="yourname" /></p>
        <input type="submit" value="Submit!" /></p>
      </form>

  </body>
</html>  
BLAH
end

puts "creating all forms example"
File.open("#{install_root}/#{app_name}/public/all_forms.html", "w") do |f|
f.write <<-BLAH
<!DOCTYPE html>
<html>
  <head>
    <title>Form with Different Fields Example</title>
    <style type="text/css">
      body {
        width: 820px;
      }
      h1 {
        color: #555;
        border-bottom: 1px solid #ccc;
      }
      p {
        color: #121212;
        font: normal 14px/16px Helvetica, sans-serif;
      }
      input[type="text"] {
        padding: 5px;
        font: normal 14px/16px Helveticam sans-serif;
        color: #555;
      }
    </style>
  </head>
 
  <body>
      <h1>Form with various fields</h1>
      <p>This form example containing text, radio, checkbox and submit input field types.</p>
      
      <form action="http://itp.nyu.edu/~#{nid}/sinatra/#{app_name}" method="GET">
        <!-- Text input fields -->
        <p><label>First Name </label><input type="text" name="firstname" /></p>
        <p><label>Last Name </label><input type="text" name="lastname" /></p>
     
        <!-- Radio input fields -->
        <p><label>Male </label><input type="radio" name="gender" value="male" /></p>
        <p><label>Female </label><input type="radio" name="gender" value="female" /></p>
     
        <!-- Checkbox input fields -->
        <p><label>Brown </label><input type="checkbox" name="hair" value="brown" /> </p>
        <p><label>Black </label><input type="checkbox" name="hair" value="black" /> </p>
        <p><label>Blond </label><input type="checkbox" name="hair" value="blond" /> </p>
        
        <!-- Submit input button -->
        <p><input type="submit" value="Submit" /></p>
      </form>

  </body>
</html>
BLAH
end

puts "checking for sinatra directory in public_html"
FileUtils.mkdir_p "/home/#{nid}/public_html/sinatra"

puts "installing symlink"
FileUtils.ln_s "#{install_root}/#{app_name}", "/home/#{nid}/public_html/sinatra/#{app_name}"

puts "giving you ownership"
FileUtils.chown_R nid, "users", "/home/#{nid}/sinatra"
FileUtils.chown_R nid, "users", "/home/#{nid}/public_html/sinatra"

puts
puts "done!"
puts "edit your new app here:"
puts "#{install_root}/#{app_name}/"
puts "and see it on the web here:"
puts "http://#{public_ip.strip}/~#{nid}/sinatra/#{app_name}"
