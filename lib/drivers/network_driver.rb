#!/usr/bin/ruby

# absolute path required since GeekTool runs from a different directory
require '~/GitHub/geeklets/lib/modules/network'

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

puts NetworkDriver::drive(!ARGV.empty? ? ARGV[0] : '')