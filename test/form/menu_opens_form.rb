#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'



def display(screen)
  menu = PPCurses::Menu.new( [ 'About PPCurses', 'Preferences', 'Quit'], nil )

  #screen.add_listener( menu )

  @win = PPCurses::Window.new(9,60,0,0)

  @form = PPCurses::Form.new(@win)
  media = PPCurses::RadioButtonGroup.new('      Media Type', %w(CD Vinyl MP3) )
  @form.add(media)


  menu.set_global_action(@form)

  menu.show
  menu.menu_selection
  menu.close
end


screen = PPCurses::Screen.new
screen.run { display(screen) }

