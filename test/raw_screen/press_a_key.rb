#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'

def wait_for_key

  Curses.setpos(0,0)
  Curses.addstr('Press any key')
  Curses.getch

end



screen = PPCurses::Screen.new
screen.run { wait_for_key }

