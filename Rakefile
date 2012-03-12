# encoding: utf-8

require 'rubygems'
require 'rake'

# require 'jeweler'
# Jeweler::Tasks.new do |gem|
#   # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
#   gem.name = "theme_park"
#   gem.homepage = "http://github.com/zires/theme_park"
#   gem.license = "MIT"
#   gem.summary = %Q{TODO: one-line summary of your gem}
#   gem.description = %Q{TODO: longer description of your gem}
#   gem.email = "zshuaibin@gmail.com"
#   gem.authors = ["Thierry Zires"]
#   # dependencies defined in Gemfile
# end
# Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
