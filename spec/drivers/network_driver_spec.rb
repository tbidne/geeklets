#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../../lib/drivers/network_driver.rb'

describe NetworkDriver do
	context "When testing network driver" do
		it "the Network module ssid method should be called" do
			expect(Network).to receive(:ssid)
			NetworkDriver::drive('ssid')
		end
		it "the Network module speed method should be called" do
			expect(Network).to receive(:speed)
			NetworkDriver::drive('speed')
		end
		it "the Network module ip method should be called" do
			expect(Network).to receive(:ip)
			NetworkDriver::drive('ip')
		end
		it "the Network module total method should be called" do
			expect(Network).to receive(:total)
			NetworkDriver::drive('total')
		end
		it "the Network module should return error message" do
			result = NetworkDriver::drive('')
			expect(result).to start_with('usage')
		end
	end
end