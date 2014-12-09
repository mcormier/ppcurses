require 'rubygems'
require 'rake'

task :default => [:build]

desc 'Build gem'
task :build do
  puts 'Building gem'
  `gem build ppcurses.gemspec`
end

desc 'Builds a new gem and installs it locally'
task :install_latest do
  Rake::Task['build'].execute
  `gem install ppcurses-0.1.0.gem`
end

desc 'Run All tests'
task :testAll do
  Rake::Task['testActions'].execute
  Rake::Task['testMenu'].execute
  Rake::Task['testForm'].execute
end

desc 'Run All Action tests'
task :testActions do
  ruby 'test/getDataAction.rb'
  ruby 'test/getEnumStringAction.rb'
  ruby 'test/getIntegerAction.rb'
  ruby 'test/getBooleanAction.rb'
  ruby 'test/getStringAction.rb'
end


desc 'Run All Menu tests'
task :testMenu do
  ruby 'test/menu/displayMenu.rb'
  ruby 'test/menu/changeMenuBorder.rb'
  ruby 'test/menu/menuInMenu.rb'
  ruby 'test/menu/compositeMenu.rb'
  ruby 'test/menu/menuWmenuItems.rb'
  ruby 'test/menu/menuItemsWTarget.rb'
end

desc 'Run All Form tests'
task :testForm do
  ruby 'test/form/simple_form.rb'
  ruby 'test/form/menu_opens_form.rb'
end
