#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

def displayMenu()
  centerMenu = PPCurses::Menu.new( [ "Press", "<ESCAPE>", "to Quit" ], nil )
  radioMenu = PPCurses::RadioMenu.new( [ "Wow", "two", "menus!" ], nil )

  mainMenu = PPCurses::CompositeMenu.new(centerMenu, radioMenu)  


  mainMenu.show()
  mainMenu.menu_selection()
  mainMenu.close()
end

screen = PPCurses::Screen.new()
screen.run { displayMenu() }

