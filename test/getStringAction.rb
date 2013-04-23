#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

action = PPCurses::GetStringAction.new("Input your name: ");

def getStringAction(action)
  action.show()
  action.execute()
end

screen = PPCurses::Screen.new()
screen.run { getStringAction(action) }

puts "Value input was: " + action.data()  
