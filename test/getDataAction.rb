#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

integer_action = PPCurses::GetIntegerAction.new('Input Integer : ')
string_action = PPCurses::GetStringAction.new('Input your name: ')

action = PPCurses::GetDataAction.new( [integer_action, string_action] )

def do_integer_action(action)
  action.show
  action.execute
end

screen = PPCurses::Screen.new
screen.run { do_integer_action(action) }

puts 'Value input was: ' + action.data.to_s
