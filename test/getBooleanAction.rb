#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

action = PPCurses::GetBooleanAction.new('Is the sky blue? ')

def do_boolean_action(action)
  action.show
  action.execute
end

screen = PPCurses::Screen.new
screen.run { do_boolean_action(action) }

puts "Value input was: #{action.data}"
