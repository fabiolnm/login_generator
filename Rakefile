require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.pattern = 'spec/**/*.rb'
  t.verbose = true
end

task default: :test
