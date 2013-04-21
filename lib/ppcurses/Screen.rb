require "curses"
include Curses

module PPCurses
	class Screen 

    def run( )
      begin
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
        #close_screen
      end
    end 

  end
end
