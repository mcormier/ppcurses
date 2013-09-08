#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

def displayMenu()
  mainMenu = PPCurses::Menu.new( [ "Press", "<ESCAPE>", "to Quit" ], nil )
  mainMenu.show()
  mainMenu.menu_selection()
  mainMenu.close()
end

screen = PPCurses::Screen.new()
screen.run { displayMenu() }

