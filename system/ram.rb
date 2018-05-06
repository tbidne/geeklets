#!/usr/bin/ruby

#---------------------#
#       Globals       #
#---------------------#

NUM_TO_CHAR = {}
i = 0
('a'..'z').each { |c| NUM_TO_CHAR[i] = c ; i += 1 }
('A'..'Y').each { |c| NUM_TO_CHAR[i] = c ; i += 1 }

#---------------------#
#      Functions      #
#---------------------#

def current_used_mem_in_mb
	# used to use `top -l1 | grep "PhysMem"` for this, but top is misleading
	# because it includes cached memory. vm_stat is better (and faster)

	stat = "vm_stat"
	grep = "grep \"pages\" -i"
	awk = "awk \'{print $3, $4}\'"

	output = `#{stat} | #{grep} | #{awk}`.split("\n").map!{ |x|
		x.scan(/[0-9]+/)[0].to_i
	}
	
	# 1 = active, 2 = inactive, 5 = wired down
	# numbers are pages of 4096 bytes so need to convert to MB
	used_mem = ((output[1] + output[2] + output[5]) * 4096) / 1000000

	# i thought we had to subtract cached from used but used seems right on its own
	# cached_mem = (output[11] * 4096) / 1000000
end

# normalizes on a scale from 0-50, prints out a letter that GeekTool interprets as
# % arc length (e.g. 'a' = 0/50, 'b' = 1/50, ... 'Y' = 50/50 i.e. full arc)
def format(mem)
	normalized = ((mem * 50 ) / 8000.0).round
	puts NUM_TO_CHAR[normalized]
end

#----------------------#
#      Executable      #
#----------------------#

mem = current_used_mem_in_mb
format(mem)