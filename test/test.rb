#!/usr/bin/env ruby

require 'ppcurses'
require 'rubygems'
require "curses"
require "sqlite3"
include Curses


init_screen
begin
  Curses.raw
  clear
  curs_set(0) # Makes cursor invisible
  noecho
  cbreak
  start_color
  
  mainMenu = PPCurses::Menu.new( [ "1RM", "3RM", "5RM" ], nil )
  mainMenu.show()
  mainMenu.getMenuSelection() 
  
  mainMenu.close()
  
  rescue SystemExit, Interrupt
  # Empty Catch block so ruby doesn't puke out
  # a stack trace when CTRL-C is used
ensure
  #close_screen
  #db.close if db
end