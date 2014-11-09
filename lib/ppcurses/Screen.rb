# Curses reference:
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/curses/rdoc/Curses.html

require 'curses'
include Curses

module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end



module Curses

  #
  #  Add some methods that allow accessing a window by PPPoint.
  #
  class Window

    def cur_point
      PPCurses::PPPoint.new(curx, cury)
    end

    def set_pos_by_point( p )
      setpos(p.y, p.x)
    end

    def move_to_point( p )
      move(p.y, p.x)
    end

  end

end



module PPCurses



  # Screen initializes the Curses screen 
  # Pass a code block to the run method to start things
  #
  # noinspection RubyResolve
  class Screen

    # Creates a curses session
    #
    # Example:
    #   >> myScreen.run { displayMenu() }
    #
    def run
      begin
        init_screen
        Curses.raw

        # Can't implement regardless as this can cause an unsupportedOperationException on some configurations
        #  like cygwin.
        if OS.unix?
          Curses.ESCDELAY=0
        end


        #  Otherwise arrow keys, etc can't be read from the main screen and cause the
        #  program to stop.
        Curses.stdscr.keypad(true)

        clear
        curs_set(INVISIBLE)
        noecho
        cbreak
        start_color

        return yield
        
      rescue SystemExit, Interrupt
        # Empty Catch block so ruby doesn't puke out
        # a stack trace when CTRL-C is used
      ensure
        close_screen
      end
    end

  end
end
