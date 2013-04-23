#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

intAction = PPCurses::GetIntegerAction.new("Input Integer : ");
stringAction = PPCurses::GetStringAction.new("Input your name: ");

action = PPCurses::GetDataAction.new( [intAction, stringAction] )

def doIntegerAction(action)
  action.show()
  action.execute()
end

screen = PPCurses::Screen.new()
screen.run { doIntegerAction(action) }

puts "Value input was: " + action.data().to_s()
