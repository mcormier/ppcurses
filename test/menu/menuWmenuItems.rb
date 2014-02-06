#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

def display_menu

  item1 = PPCurses::MenuItem.new('Item 1')
  item2 = PPCurses::MenuItem.new('Item 2')
  item2.state=PPCurses::PP_ON_STATE         # Displays a checkbox next to the menu item
  item3 = PPCurses::MenuItem.new('Item 3')

  main_menu = PPCurses::Menu.new( [ item1, item2, item3], nil )
  main_menu.show
  main_menu.menu_selection
  main_menu.close
end

screen = PPCurses::Screen.new
screen.run { display_menu }

