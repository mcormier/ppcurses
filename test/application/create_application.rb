#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


class MyDelegate

  def applicationDidFinishLaunching( app )

  end

end

# action = PPCurses::GetBooleanAction.new('Is the sky blue? ')
#
# def do_boolean_action(action)
#   action.show
#   action.execute
# end

delegate = MyDelegate.new

app = PPCurses::Application.new
app.set_delegate(delegate)
app.launch

#screen.run { do_boolean_action(action) }

#puts "Value input was: #{action.data}"
