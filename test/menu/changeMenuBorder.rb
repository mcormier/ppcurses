#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

def display_menu
  menu = PPCurses::Menu.new( [ 'Press', '<ESCAPE>', 'to Quit'] )
  menu.side_wall_char = '\\'
  menu.top_bot_wall_char = '='

  menu.show
  menu.menu_selection
  menu.close
end

screen = PPCurses::Screen.new
screen.run { display_menu }
