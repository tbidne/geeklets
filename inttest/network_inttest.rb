#!/usr/bin/ruby

require 'rspec'
require_relative '../lib/drivers/network_driver.rb'

describe "Network" do
	context "When testing the network" do
		it "should get the ssid" do
			result = NetworkDriver::drive("ssid")
			expect(result).to start_with("SSID: ")
		end

		it "should get the ip" do
			result = NetworkDriver::drive("ip").split("\n")
			expect(result[0]).to match(/Local\sIP:\s+[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/)
			expect(result[1]).to match(/Global\sIP:\s+[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/)
		end

		it "should get the speed" do
			result = NetworkDriver::drive("speed").split("\n")
			expect(result[0]).to match(/Down:\s+[0-9]+\.0\s[KMG]b\/s/)
			expect(result[1]).to match(/Up:\s+[0-9]+\.0\s[KMG]b\/s/)
		end

		it "should get the total traffic" do
			result = NetworkDriver::drive("total").split("\n")
			expect(result[0]).to match(/Downloaded:\s+[0-9]+.[0-9]+\s[KMG]B/)
			expect(result[1]).to match(/Uploaded:\s+[0-9]+.[0-9]+\s[KMG]B/)
		end
	end
end