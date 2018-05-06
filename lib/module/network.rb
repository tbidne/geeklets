#!/usr/bin/ruby

#---------------------#
#      Functions      #
#---------------------#

module Network
	def self.ssid
		airport = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I"
		grep = "grep -i ssid | grep -iv BSSID"
		awk = "awk \'{print $2, $3, $4, $5, $6}\'"

		output = `#{airport} | #{grep} | #{awk}`
		"SSID: #{output}".strip
	end

	def self.speed
		netstat = "netstat -bI \'en0\'"
		awk = "awk \"/en0/\"\'{print $7\" \"$10; exit}\'"
		sample_a = `#{netstat} | #{awk}`.split(" ").map!(&:to_i)
		sleep 1
		sample_b = `#{netstat} | #{awk}`.split(" ").map!(&:to_i)

		down = (sample_b[0] - sample_a[0])
		up = (sample_b[1] - sample_a[1])

		down_str = down < 1000 ? "#{down.round(2)} Kb/s" : "#{(down / 1000).round(2)} Mb/s"
		up_str = up < 1000 ? "#{up.round(2)} Kb/s" : "#{(up / 1000).round(2)} Mb/s"

		"Down: #{down_str}\nUp:     #{up_str}"
	end

	def self.ip
		# local
		ifconfig = "ifconfig en0"
		grep = "grep inet | grep -v inet6"
		awk = "awk '{print $2}'"
		local = `#{ifconfig} | #{grep} | #{awk}`

		# global
		curl = "curl --silent http://ipecho.net/plain"
		global = `#{curl}`

		"Local IP:  #{local}Global IP: #{global}"
	end

	def self.total
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

		"Downloaded: #{down_str}\nUploaded:     #{up_str}"
	end
end