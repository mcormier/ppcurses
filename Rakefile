require 'rubygems'
require 'rake'

task :default => [:build]

desc "Build gem"
task :build do
  puts "Building gem"
  `gem build ppcurses.gemspec`
end

desc "Run All tests"
task :testAll do
  ruby  "test/getBooleanAction.rb"
  ruby  "test/getStringAction.rb"
  ruby  "test/menuInMenu.rb"
  ruby  "test/compositeMenu.rb"
  ruby  "test/displayMenu.rb"
end
