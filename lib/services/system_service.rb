module SystemService
	def self.memory_statistics
		# used to use `top -l1 | grep "PhysMem"` for this, but top is misleading
		# because it includes cached memory. vm_stat is better (and faster)

		stat = "vm_stat"
		grep = "grep \"pages\" -i"
		awk = "awk \'{print $3, $4}\'"

		`#{stat} | #{grep} | #{awk}`
	end

	def self.uptime
		uptime = "uptime"
		cut = "cut -c 11-100"
		awk = "awk \'{split($0, a, \"[ mins]*, [1234567890]+ user\"); sub(\":\", \"h \", a[1]); sub(\" day,  \", \"d \", a[1]); print \"Up for \" a[1] \" mins\" }\'"
		
		`#{uptime} | #{cut} | #{awk}`
	end
end