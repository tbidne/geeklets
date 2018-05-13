#!/usr/bin/ruby

require_relative '../modules/network'

# Driver for the Network module
module NetworkDriver
  def self.drive(method)
    case method
    when 'ssid'
      Network.ssid
    when 'speed'
      Network.speed
    when 'ip'
      Network.ip
    when 'total'
      Network.total
    else
      'usage: ./network.rb [ssid] [networkSpeed] [ip] [total]'
    end
  end
end

result = NetworkDriver.drive(ARGV[0])
puts result unless result.start_with?('usage')
