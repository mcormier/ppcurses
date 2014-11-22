#noinspection RubyResolve
module PPCurses
  class BaseAction

    def set_window(win)
      @win = win
    end

    def x_padding
      self.win_padding
    end

    def win_padding
       2
    end

    # TODO -- need abstraction layer.
    def win_width
      Curses.cols - win_padding
    end

    def win_height
      Curses.lines - win_padding
    end

    def create_window
      @win = Window.new( self.win_height, self.win_width,
                         self.win_padding/2, self.win_padding/2)
      @win.clear
      @win.box('|', '-')
      @win.setpos(@win.cury+1, self.x_padding )
    end

    def show
      if @win.nil?
        self.create_window
      end

      @win.refresh
    end

  end

end
