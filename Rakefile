require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

RSpec::Core::RakeTask.new(:inttest) do |t|
    t.pattern = 'inttest/*_inttest.rb'
    t.verbose = true
end
