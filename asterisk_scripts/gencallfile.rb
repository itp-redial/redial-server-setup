#!/usr/bin/ruby
require 'fileutils'
# Get Arguments
# First argument Number to Call
numbertocall = ""
if (ARGV.size > 0)
  numbertocall = ARGV[0]
else
	puts "USAGE: gencallfile.rb [phone-number] [context] [exten] [varname=value] [hour-minute-second-month-day-year]\n"
	exit(1)
end

# Context
context = ARGV[1] || "itp-redial"
# Extension
extension = ARGV[2] || "s"
#variables
vars = ARGV[3] || ""
#future time
touchtime = ARGV[4] || ""

time = (Time.now.to_f * 1000).to_i 	#current timestamp
temp_dir = "/tmp/"
callfile = "call_" + time.to_s + ".call"
startcallfile = temp_dir + callfile
end_dir = "/var/spool/asterisk/outgoing/"
endcallfile = end_dir + callfile
#write file to disk
file = File.open(startcallfile,"w")
file.puts("Channel: SIP/flowroute/" + numbertocall + "\n")
file.puts("MaxRetries: 1\n")
file.puts("RetryTime: 60\n")
file.puts("WaitTime: 30\n")
file.puts("Context: " + context + "\n")
file.puts("Extension: " + extension + "\n")
file.puts("Set: " + vars + "\n") unless vars == ""
file.close
#change file permission
File.chmod(0777, startcallfile)
FileUtils.chown(ENV['USER'],'asterisk',startcallfile)
#hour-minute-second-month-day-year (example: 02-10-00-09-27-2007)
if (touchtime != "")
	timesplit = touchtime.split('-')
	ctime = Time.local(timesplit[5],timesplit[3],timesplit[4],timesplit[0],timesplit[1],timesplit[2])
	File.utime(ctime,ctime,startcallfile) #change file time to future date
end 

#move file to /var/spool/asterisk/outgoing
FileUtils.mv(startcallfile,endcallfile)
