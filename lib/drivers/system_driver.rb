#!/usr/bin/ruby

require_relative '../modules/system'

# Driver for the Sytem module
module SystemDriver
  def self.drive(method)
    case method
    when 'memory'
      System.mb_to_geektool_format(System.current_used_mem_in_mb)
    when 'uptime'
      System.uptime
    else
      ''
    end
  end
end

result = SystemDriver.drive(ARGV[0])
puts result unless result.empty?
