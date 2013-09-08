#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

def display_menu
  center_menu = PPCurses::Menu.new( [ 'Press', '<ESCAPE>', 'to Quit'], nil )
  radio_menu = PPCurses::RadioMenu.new( %w(Wow two menus!), nil )

  main_menu = PPCurses::CompositeMenu.new(center_menu, radio_menu)


  main_menu.show()
  main_menu.menu_selection()
  main_menu.close()
end

screen = PPCurses::Screen.new()
screen.run { display_menu() }

