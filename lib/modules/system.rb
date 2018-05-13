#!/usr/bin/ruby

require_relative '../services/system_service.rb'

# Module for parsing system info for geektool
module System
  @num_to_char = {}
  i = 0
  (('a'..'z').to_a + ('A'..'Z').to_a).each do |c|
    @num_to_char[i] = c
    i += 1
  end

  def self.current_used_mem_in_mb
    output = SystemService.memory_statistics.split("\n").map! do |x|
      x.scan(/[0-9]+/)[0].to_i
    end

    # 1 = active, 2 = inactive, 3 = speculative, 5 = wired down
    # numbers are pages of 4096 bytes so need to convert to MB
    used_mem = ((output[1] + output[2] + output[3] + output[5]) * 4096) \
      / 1_000_000
    cached_mem = (output[11] * 4096) / 1_000_000
    used_mem - cached_mem
  end

  # normalizes on a scale from 0-50, prints out a letter that GeekTool
  # interprets as % arc length (e.g. 'a' = 0/50, 'b' = 1/50, ...
  # 'Y' = 50/50 i.e. full arc)
  def self.mb_to_geektool_format(mem)
    normalized = ((mem * 50) / 8_000.0).round
    @num_to_char[normalized]
  end

  def self.uptime
    SystemService.uptime
  end
end
