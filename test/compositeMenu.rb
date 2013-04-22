#!/usr/bin/env ruby

require 'rubygems'
require 'ppcurses'

def displayMenu()
  centerMenu = PPCurses::Menu.new( [ "Press", "<ESCAPE>", "to Quit" ], nil )
  radioMenu = PPCurses::RadioMenu.new( [ "Wow", "another", "menu" ], nil )

  mainMenu = PPCurses::CompositeMenu.new(centerMenu, radioMenu)  


  mainMenu.show()
  mainMenu.getMenuSelection() 
  mainMenu.close()
end

screen = PPCurses::Screen.new()
screen.run { displayMenu() }

