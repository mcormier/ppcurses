#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

action = PPCurses::GetEnumeratedStringAction.new('Media Type? ', %w(CD Vinyl MP3))

def do_action(action)
  action.show()
  action.execute()
end

screen = PPCurses::Screen.new()
screen.run { do_action(action) }

puts 'Value input was: ' + action.data()
