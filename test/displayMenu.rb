#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

def displayMenu()
  mainMenu = PPCurses::Menu.new( [ "Press", "<ESCAPE>", "to Quit" ], nil )
  mainMenu.show()
  mainMenu.getMenuSelection() 
  mainMenu.close()
end

screen = PPCurses::Screen.new()
screen.run { displayMenu() }

