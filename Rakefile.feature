$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'cucumber/rake/task'
 
Cucumber::Rake::Task.new(:features)
 
task :default => :features