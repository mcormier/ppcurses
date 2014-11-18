require 'rubygems'
require 'thread'

# This program demonstrates that the curses getch call blocks all Ruby
# threads.
#
# The code comes from a 2009 blog post by William Morgan.
# http://masanjin.net/blog/ruby-ncurses-and-thread-blocking
#
#
# Morgan is the original developer of Sup, a ruby curse email client (https://github.com/sup-heliotrope/sup)
# and he works for tweeter now.
#
# Here is the original code from the post.
=begin
require 'ncurses'

Ncurses.initscr
Ncurses.noecho
Ncurses.cbreak
Ncurses.curs_set 0

Thread.new do
  sleep 0.1
  Ncurses.stdscr.mvaddstr 0, 0, "library is GOOD."
end

begin
  Ncurses.stdscr.mvaddstr 0, 0, "library is BAD."
  Ncurses.getch
ensure
  Ncurses.curs_set 1
  Ncurses.endwin
  puts "bye"
end
=end

# Here is the port.

require 'curses'

Thread.new do
  sleep 0.1
  Curses.stdscr.setpos(0, 0)
  Curses.stdscr.addstr('library is GOOD')
end



Curses.init_screen
Curses.raw
Curses.clear
Curses.curs_set(0)
Curses.noecho
Curses.cbreak
Curses.start_color

Curses.stdscr.setpos(0, 0)
Curses.stdscr.addstr('library is BAD')
Curses.stdscr.getch


Curses.close_screen