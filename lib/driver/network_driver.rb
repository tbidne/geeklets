#!/usr/bin/ruby

# absolute path required since GeekTool runs from a different directory
require '~/GitHub/geeklets/lib/module/network'

if ARGV.size == 1
	case ARGV[0]
	when "ssid"
		puts Network::ssid
	when "speed"
		puts Network::speed
	when "ip"
		puts Network::ip
	when "total"
		puts Network::total
	end
else
	puts "usage: ./network.rb [ssid] [networkSpeed] [ip] [total]"
end