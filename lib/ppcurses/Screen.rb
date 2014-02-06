# Curses reference:
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/curses/rdoc/Curses.html

require 'curses'
include Curses

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
        # TODO -- Sniff whether terminal supports unicode or not.

        init_screen
        Curses.raw
        clear
        curs_set(0) # Makes cursor invisible
        noecho
        cbreak
        start_color
      
        yield 
        
      rescue SystemExit, Interrupt
        # Empty Catch block so ruby doesn't puke out
        # a stack trace when CTRL-C is used
      ensure
        close_screen
      end
    end 

  end
end
