require "curses"

module PPCurses
  class BaseAction

    def setWindow(win)
      @win = win
    end

    def winPadding()
      return 2
    end

    def winWidth()
      Curses.cols - winPadding()
    end

    def winHeight()
      Curses.lines - winPadding()
    end

    def createWindow()
      @win = Window.new( winHeight(), winWidth(), 
                         winPadding()/2, winPadding()/2)
      @win.clear
      @win.box("|", "-")
    end

    def show()
      if @win.nil?
        self.createWindow()
      end

      @win.refresh
    end

  end

end
