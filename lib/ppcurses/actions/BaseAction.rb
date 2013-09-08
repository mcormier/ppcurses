require 'curses'

module PPCurses
  class BaseAction

    def setWindow(win)
      @win = win
    end

    def xPadding
      self.winPadding()
    end

    def winPadding
       2
    end

    def winWidth
      Curses.cols - winPadding()
    end

    def winHeight
      Curses.lines - winPadding()
    end

    def create_window
      @win = Window.new( winHeight(), winWidth(), 
                         winPadding()/2, winPadding()/2)
      @win.clear
      @win.box('|', '-')
      @win.setpos(@win.cury()+1, xPadding() )
    end

    def show
      if @win.nil?
        self.create_window()
      end

      @win.refresh
    end

  end

end
