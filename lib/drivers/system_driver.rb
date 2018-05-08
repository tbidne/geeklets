#!/usr/bin/ruby

require_relative '../modules/system'

module SystemDriver
	def self.drive(method)
		case method
		when "memory"
			System::mb_to_geektool_format(System::current_used_mem_in_mb)
		else
			''
		end
	end
end

result = SystemDriver::drive(ARGV[0])
if !result.empty? then puts result end