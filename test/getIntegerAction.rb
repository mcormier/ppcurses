#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

action = PPCurses::GetIntegerAction.new("Input Integer : ");

def doIntegerAction(action)
  action.show()
  action.execute()
end

screen = PPCurses::Screen.new()
screen.run { doIntegerAction(action) }

puts "Value input was: " + action.data()  
