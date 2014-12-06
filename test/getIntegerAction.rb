#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

action = PPCurses::GetIntegerAction.new('Input Integer : ')

def do_integer_action(action)
  action.show
  action.execute
end

screen = PPCurses::Screen.new
screen.run { do_integer_action(action) }

puts "Value input was: #{action.data}"
