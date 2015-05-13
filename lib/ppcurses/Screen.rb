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
      PPCurses::Point.new(curx, cury)
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


    def setup_curses
      Curses.init_screen
      Curses.raw

      # Can't implement regardless as this can cause an unsupportedOperationException on some configurations
      #  like cygwin.
      if OS.unix?
        Curses.ESCDELAY=0
      end


      #  Otherwise arrow keys, etc can't be read from the main screen and cause the
      #  program to stop.
      Curses.stdscr.keypad(true)

      Curses.clear
      Curses.curs_set(INVISIBLE)
      Curses.noecho
      Curses.cbreak
      Curses.start_color
    end

    def print_with_attribute( toPrint, attribute )
      Curses.stdscr.attron( attribute )
      Curses.stdscr.addstr( toPrint )
      Curses.stdscr.attroff( attribute )
    end

    def get_ch
      Curses.stdscr.getch
    end

    def width
      Curses.cols
    end

    def height
      Curses.lines
    end

    def set_pos_by_point( p )
      setpos(p.y, p.x)
    end

    def setpos(y, x)
      Curses.stdscr.setpos(y, x)
    end

    def clrtoeol
      Curses.stdscr.clrtoeol
    end

    def attron(attributes)
      Curses.stdscr.attron(attributes)
    end

    def attroff(attributes)
      Curses.stdscr.attroff(attributes)
    end

    def addstr(string)
      Curses.stdscr.addstr(string)
    end

    def getch
      Curses.stdscr.getch
    end

    def cur_point
      PPCurses::Point.new(Curses.stdscr.curx, Curses.stdscr.cury)
    end

    def curs_set(value)
      Curses.curs_set(value)
    end


    def shutdown_curses
      Curses.close_screen
    end

    # Creates a curses session
    #
    # Example:
    #   >> myScreen.run { displayMenu() }
    #
    def run
      begin
        setup_curses

        return yield
        
      rescue SystemExit, Interrupt
        # Empty Catch block so ruby doesn't puke out
        # a stack trace when CTRL-C is used
      ensure
         shutdown_curses
      end
    end

  end
end
