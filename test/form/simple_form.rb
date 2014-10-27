#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'




def display_form


  first_name = PPCurses::InputElement.new("FirstName", 10)
  form = PPCurses::Form.new(Curses)

  Curses.getch

end



screen = PPCurses::Screen.new
screen.run { display_form }



