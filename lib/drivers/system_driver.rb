#!/usr/bin/ruby

# absolute path required since GeekTool runs from a different directory
require '~/GitHub/geeklets/lib/modules/system'

module SystemDriver
	def self.drive
		System::mb_to_geektool_format(System::current_used_mem_in_mb)
	end
end

puts SystemDriver::drive