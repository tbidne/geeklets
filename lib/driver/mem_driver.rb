#!/usr/bin/ruby

# absolute path required since GeekTool runs from a different directory
require '~/GitHub/geeklets/lib/module/mem'

puts Mem::format(Mem::current_used_mem_in_mb)