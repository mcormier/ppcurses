require 'curses'

#noinspection RubyResolve
module PPCurses
  class BaseAction

    def set_window(win)
      @win = win
    end

    def x_padding
      self.win_padding()
    end

    def win_padding
       2
    end

    def win_width
      Curses.cols - win_padding()
    end

    def win_height
      Curses.lines - win_padding()
    end

    def create_window
      @win = Window.new( win_height(), win_width(),
                         win_padding()/2, win_padding()/2)
      @win.clear
      @win.box('|', '-')
      @win.setpos(@win.cury()+1, x_padding() )
    end

    def show
      if @win.nil?
        self.create_window()
      end

      @win.refresh
    end

  end

end
