#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../lib/module/mem.rb'

describe Mem do
	context "When testing Mem" do
		it "should parse the current memory usage" do
			result = Mem::current_used_mem_in_mb
			expect(result.to_s.size).to be > 1
		end

		it "should format the used memory" do
			result = Mem::format(8000)
			expect(result).to eq "Y"
		end
	end
end