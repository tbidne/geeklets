#!/usr/bin/ruby

require_relative '../modules/system'

module SystemDriver
	def self.drive
		System::mb_to_geektool_format(System::current_used_mem_in_mb)
	end
end

puts SystemDriver::drive