#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../../lib/services/system_service.rb'

describe SystemService do
	context "When testing system service" do
		it "should execute bash command for memory" do
			stat = "vm_stat"
			grep = "grep \"pages\" -i"
			awk = "awk \'{print $3, $4}\'"

			expect(SystemService).to receive(:`).with("#{stat} | #{grep} | #{awk}")

			SystemService::memory_statistics
		end

		it "should execute bash command for uptime" do
			uptime = "uptime"
			cut = "cut -c 11-100"
			awk = "awk \'{split($0, a, \"[ mins]*, [1234567890]+ user\"); sub(\":\", \"h \", a[1]); sub(\" day,  \", \"d \", a[1]); print \"Up for \" a[1] \" mins\" }\'"

			expect(SystemService).to receive(:`).with("#{uptime} | #{cut} | #{awk}")

			SystemService::uptime
		end
	end
end