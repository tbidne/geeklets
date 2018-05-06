#!/usr/bin/ruby

#---------------------#
#      Functions      #
#---------------------#

def ssid
  airport = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I"
  grep = "grep -i ssid | grep -iv BSSID"
  awk = "awk \'{print $2, $3, $4, $5, $6}\'"
  
  output = `#{airport} | #{grep} | #{awk}`
  puts "SSID: #{output}"
end

def speed
  netstat = "netstat -bI \'en0\'"
  awk = "awk \"/en0/\"\'{print $7\" \"$10; exit}\'"
  sample_a = `#{netstat} | #{awk}`.split(" ").map!(&:to_i)
  sleep 1
  sample_b = `#{netstat} | #{awk}`.split(" ").map!(&:to_i)

  down = (sample_b[0] - sample_a[0])
  up = (sample_b[1] - sample_a[1])

  down_str = down < 1000 ? "#{down.round(2)} Kb/s" : "#{(down / 1000).round(2)} Mb/s"
  up_str = up < 1000 ? "#{up.round(2)} Kb/s" : "#{(up / 1000).round(2)} Mb/s"

  puts "Down: #{down_str}\nUp:     #{up_str}"
end

def ip
  # local
  ifconfig = "ifconfig en0"
  grep = "grep inet | grep -v inet6"
  awk = "awk '{print $2}'"
  local = `#{ifconfig} | #{grep} | #{awk}`

  # global
  curl = "curl --silent http://ipecho.net/plain"
  global = `#{curl}`
  
  puts "Local IP:  #{local}Global IP: #{global}"
end

def total
  top = "top -l5"
  grep = "grep \"Networks\""
  tail = "tail -1"
  
  # todo: fix K/M bug here
  data = `#{top} | #{grep} | #{tail}`
  args = data.scan(/^Networks: packets: [0-9]*\/([0-9]*)[KM] in, [0-9]*\/([0-9]*)[KM] out.$/)
  
  down = args[0][0].to_f
  up = args[0][1].to_f
  
  down_str = down < 1000 ? "#{down} MB" : "#{down / 1000} GB"
  up_str = up < 1000 ? "#{up} MB" : "#{up / 1000} GB"
  
  puts "Downloaded: #{down_str}\nUploaded:     #{up_str}"
end

#----------------------#
#      Executable      #
#----------------------#

error = false
if ARGV.size < 5
  ARGV.each { |cmd|
    begin
      send(cmd)
    rescue NoMethodError => e
      puts "#{cmd} is not a valid function"
      error = true
    end
  }
else
  error = true
end

if error || ARGV.empty?
  puts "usage: ./network.rb [ssid] [networkSpeed] [ip] [total]"
end