#!/usr/bin/ruby

require 'rspec'
require_relative '../lib/drivers/system_driver.rb'

describe "System" do
	context "When testing the system" do
		it "should get the current memory usage in geektool formate" do
			result = SystemDriver::drive("memory")
			expect((('a'..'z').to_a + ('A'..'Y').to_a)).to include(result)
		end
		
		it "should get the formatted uptime" do
			result = SystemDriver::drive("uptime")
			expect(result).to start_with("Up for")
		end
	end
end