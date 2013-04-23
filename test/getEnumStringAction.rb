#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

action = PPCurses::GetEnumeratedStringAction.new("Media Type? ",
              ["CD", "Vinyl", "MP3"] );

def doAction(action)
  action.show()
  action.execute()
end

screen = PPCurses::Screen.new()
screen.run { doAction(action) }

puts "Value input was: " + action.data()  
