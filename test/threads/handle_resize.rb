require 'curses'

#
#  Resizing the window shouldn't cause an error.
#
#  Currently it does in Curses 1.0.1 because getch is blocking all
#  Ruby threads.
#

@listeners = []

def size_changed

  # Calling the each method on the array will cause the following error:
  # undefined method `call' for []:Array (NoMethodError)
  #
  @listeners.each { |listener|
    # Notify all listeners ...
 }
end


begin
  Signal.trap('SIGWINCH', size_changed )

  Curses.init_screen
  Curses.raw
  Curses.clear
  Curses.curs_set(0)
  Curses.noecho
  Curses.cbreak
  Curses.start_color

  Curses.stdscr.setpos(0, 0)
  Curses.stdscr.addstr("Resizing window shouldn't cause an error ")
  Curses.stdscr.getch

rescue SystemExit, Interrupt
  # Empty Catch block so ruby doesn't puke out
  # a stack trace when CTRL-C is used
ensure
  Curses.close_screen
end