#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../lib/module/network.rb'

describe Network do
	context "When testing Network" do
		it "should parse the ssid" do
			result = Network::ssid
			expect(result).to start_with("SSID: ")
			expect(result.size).to be > 6
		end

		it "should parse the speed" do
			result = Network::speed.split("\n")
			down = result[0].scan(/Down:\s([0-9]+)\.([0-9])+\s[KM]b\/s/)
			up = result[1].scan(/Up:\s+([0-9]+)\.([0-9])+\s[KM]b\/s/)
			expect(down[0].size).to eq 2
			expect(up[0].size).to eq 2
		end

		it "should parse the ip" do
			result = Network::ip.split("\n")
			local = result[0]
			global = result[1]
			expect(local.size).to be > 11
			expect(global.size).to be > 11
		end

		it "should parse the total" do
			result = Network::total.split("\n")
			down = result[0].scan(/Downloaded:\s([0-9]+)\.([0-9])+\s[KM]B/)
			up = result[1].scan(/Uploaded:\s+([0-9]+)\.([0-9])+\s[KM]B/)
			expect(down[0].size).to eq 2
			expect(up[0].size).to eq 2
		end
	end
end