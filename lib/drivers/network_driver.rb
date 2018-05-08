#!/usr/bin/ruby

require_relative '../modules/network'

module NetworkDriver
	def self.drive(method)
			case method
			when "ssid"
				Network::ssid
			when "speed"
				Network::speed
			when "ip"
				Network::ip
			when "total"
				Network::total
			else
				"usage: ./network.rb [ssid] [networkSpeed] [ip] [total]"
			end
	end
end

result = NetworkDriver::drive(ARGV[0])
if !result.start_with?("usage") then puts result end