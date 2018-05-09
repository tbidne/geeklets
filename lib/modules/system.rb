#!/usr/bin/ruby

require_relative '../services/system_service.rb'

module System
	NUM_TO_CHAR = {}
	i = 0
	('a'..'z').each { |c| NUM_TO_CHAR[i] = c ; i += 1 }
	('A'..'Y').each { |c| NUM_TO_CHAR[i] = c ; i += 1 }

	def self.current_used_mem_in_mb
		output = SystemService::memory_statistics.split("\n").map!{ |x|
			x.scan(/[0-9]+/)[0].to_i
		}
	
		# 1 = active, 2 = inactive, 3 = speculative, 5 = wired down
		# numbers are pages of 4096 bytes so need to convert to MB
		used_mem = ((output[1] + output[2] + output[3] + output[5]) * 4096) / 1000000
		cached_mem = (output[11] * 4096) / 1000000
		used_mem - cached_mem
	end

	# normalizes on a scale from 0-50, prints out a letter that GeekTool interprets as
	# % arc length (e.g. 'a' = 0/50, 'b' = 1/50, ... 'Y' = 50/50 i.e. full arc)
	def self.mb_to_geektool_format(mem)
		normalized = ((mem * 50 ) / 8000.0).round
		NUM_TO_CHAR[normalized]
	end

	def self.uptime
		SystemService::uptime
	end
end