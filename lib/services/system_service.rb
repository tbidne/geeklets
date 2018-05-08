module SystemService
	def self.current_used_mem_in_meb
		# used to use `top -l1 | grep "PhysMem"` for this, but top is misleading
		# because it includes cached memory. vm_stat is better (and faster)

		stat = "vm_stat"
		grep = "grep \"pages\" -i"
		awk = "awk \'{print $3, $4}\'"

		`#{stat} | #{grep} | #{awk}`
	end
end