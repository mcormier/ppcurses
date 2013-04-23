#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

action = PPCurses::GetBooleanAction.new("Is the sky blue? ");

def doBooleanAction(action)
  action.show()
  action.execute()
end

screen = PPCurses::Screen.new()
screen.run { doBooleanAction(action) }

puts "Value input was: " + action.data()  
