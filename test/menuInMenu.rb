#!/usr/bin/env ruby

require 'rubygems'
require_relative '../lib/ppcurses.rb'

def displayMenu()
  mainMenu = PPCurses::Menu.new( [ "Press", "<ESCAPE>", "to Quit" ], nil )
  innerMenu = PPCurses::Menu.new( [ "Wow", "another", "menu" ], nil )

  menuAction = PPCurses::ShowMenuAction.new(innerMenu) 
  mainMenu.setGlobalAction(menuAction)

  mainMenu.show()
  mainMenu.getMenuSelection() 
  mainMenu.close()
end

screen = PPCurses::Screen.new()
screen.run { displayMenu() }

