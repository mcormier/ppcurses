#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

def display_menu
  main_menu = PPCurses::Menu.new( [ 'Press', '<ESCAPE>', 'to Quit'], nil )
  inner_menu = PPCurses::Menu.new( %w(Wow another menu), nil )

  menu_action = PPCurses::ShowMenuAction.new(inner_menu)
  main_menu.set_global_action(menu_action)

  main_menu.show
  main_menu.menu_selection
  main_menu.close
end

screen = PPCurses::Screen.new
screen.run { display_menu }

