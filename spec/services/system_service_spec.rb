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
	end
end