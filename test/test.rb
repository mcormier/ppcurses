#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

def displayMenu()
  mainMenu = PPCurses::Menu.new( [ "1RM", "3RM", "5RM" ], nil )
  mainMenu.show()
  mainMenu.getMenuSelection() 
  mainMenu.close()
end

screen = PPCurses::Screen.new()
screen.run { displayMenu() }

