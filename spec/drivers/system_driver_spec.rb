#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../../lib/drivers/system_driver.rb'

describe SystemDriver do
	context "When testing system driver" do
		it "should print formatted memory" do
			expect(System).to receive(:current_used_mem_in_mb).and_return(4000)
			expect(System).to receive(:mb_to_geektool_format).and_return("z")

			result = SystemDriver::drive

			expect(result).to eql "z"
		end
	end
end