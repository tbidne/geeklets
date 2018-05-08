#!/usr/bin/ruby

require_relative '../services/network_service.rb'

#---------------------#
#      Functions      #
#---------------------#

module Network

	@@byte_suffix_map = {
		"K" => "M",
		"M" => "G"
	}

	def self.ssid
		output = NetworkService::ssid
		"SSID: #{output}".strip
	end

	def self.speed
		sample_a = NetworkService::speed.split(" ").map!(&:to_i)
		sleep 1
		sample_b = NetworkService::speed.split(" ").map!(&:to_i)

		down = (sample_b[0] - sample_a[0])
		up = (sample_b[1] - sample_a[1])

		down_str = down < 1000 ? "#{down.round(2)} Kb/s" : "#{(down / 1000).round(2)} Mb/s"
		up_str = up < 1000 ? "#{up.round(2)} Kb/s" : "#{(up / 1000).round(2)} Mb/s"

		"Down: #{down_str}\nUp:     #{up_str}"
	end

	def self.ip
		local = NetworkService::ip_local
		global = NetworkService::ip_global

		"Local IP:  #{local}Global IP: #{global}"
	end

	def self.format_bytes(bytes, suffix)
		bytes >= 1000 ? "#{bytes / 1000} #{@@byte_suffix_map[suffix]}B" : "#{bytes} #{suffix}B"
	end

	private_class_method :format_bytes

	def self.total
		data = NetworkService::total
		args = data.scan(/^Networks: packets: [0-9]*\/([0-9]*)([KM]) in, [0-9]*\/([0-9]*)([KM]) out.$/)

		down = args[0][0].to_f
		up = args[0][2].to_f

		down_str = format_bytes(down, args[0][1])
		up_str = format_bytes(up, args[0][3])

		"Downloaded: #{down_str}\nUploaded:     #{up_str}"
	end
end