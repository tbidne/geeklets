module NetworkService
	def self.ssid
		airport = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I"
		grep = "grep -i ssid | grep -iv BSSID"
		awk = "awk \'{print $2, $3, $4, $5, $6}\'"

		`#{airport} | #{grep} | #{awk}`
	end

	def self.speed
		netstat = "netstat -bI \'en0\'"
		awk = "awk \"/en0/\"\'{print $7\" \"$10; exit}\'"

		`#{netstat} | #{awk}`
	end

	def self.ip_local
		ifconfig = "ifconfig en0"
		grep = "grep inet | grep -v inet6"
		awk = "awk '{print $2}'"
		`#{ifconfig} | #{grep} | #{awk}`
	end

	def self.ip_global
		curl = "curl --silent http://ipecho.net/plain"
		`#{curl}`
	end

	def self.total
		top = "top -l5"
		grep = "grep \"Networks\""
		tail = "tail -1"

		`#{top} | #{grep} | #{tail}`
	end
end