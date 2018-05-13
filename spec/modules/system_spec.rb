#!/usr/bin/ruby

require 'spec_helper.rb'
require_relative '../../lib/modules/system.rb'

describe System do
  context 'When testing System memory' do
    before(:each) do
      # 6000 mb: (1464844 * 4096) / 1000000 = 6000 (rounding)
      active = 1_400_000
      inactive = 60_000
      speculative = 844
      wired = 4_000

      # 2000 gb: (488282 * 4096) / 1000000 = 2000 (rounding)
      cached = 488_282

      output = "384143. \n#{active}. \n#{inactive}. \n#{speculative}. \n0. " \
      "\ndown: #{wired}.\n65903. \n33558842. \nfilled: 149832829.\n3223108. " \
      "\n91635. \n#{cached}. \n928204. \nin compressor:\nby compressor:\n"

      allow(SystemService).to receive(:memory_statistics).and_return(output)
    end

    it 'should parse the current memory usage' do
      result = System.current_used_mem_in_mb
      expect(result).to be_within(1).of(4_000)
    end

    it 'should format the used memory' do
      result = System.mb_to_geektool_format(8_000)
      expect(result).to eq 'Y'
    end

    it 'should get the uptime' do
      expect(SystemService).to receive(:uptime)
      System.uptime
    end
  end
end
