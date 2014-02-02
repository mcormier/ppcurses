#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

def display_menu
  main_menu = PPCurses::Menu.new( [ 'Press', '<ESCAPE>', 'to Quit'], nil )
  main_menu.show
  main_menu.menu_selection
  main_menu.close
end

screen = PPCurses::Screen.new
screen.run { display_menu }

