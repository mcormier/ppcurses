#!/usr/bin/env ruby

require 'rubygems'
require_relative '../../lib/ppcurses.rb'


@index = 0

@x_loc = 0
@y_loc = 0

def print_value(value, text_color, bg_color)
  pair_index = @index + 1
  Curses.setpos(@y_loc, @x_loc)
  Curses.init_pair(pair_index, text_color, bg_color)
  color_pair = Curses.color_pair(pair_index)
  Curses.attron(color_pair)
  out_string = "#{value}"
  @x_loc = @x_loc + 5

  if @x_loc  > Curses.cols
    @x_loc = 0
    @y_loc = @y_loc + 1
    Curses.setpos(@y_loc, @x_loc)
  end

  Curses.addstr(out_string.ljust(5))
  Curses.attroff(color_pair)
  @index = @index + 1
end


def wait_for_key


  for i in 0..255
    print_value("#{i}",  0,  i )
  end


  Curses.getch

end



screen = PPCurses::Screen.new
screen.run { wait_for_key }

=begin

  There are 8 default defined colors.

  COLOR_BLACK   = 0
  COLOR_RED     = 1
  COLOR_GREEN   = 2
  COLOR_YELLOW  = 3
  COLOR_BLUE    = 4
  COLOR_MAGENTA = 5
  COLOR_CYAN    = 6
  COLOR_WHITE   = 7


=end

puts Curses.cols
puts "blah".length


