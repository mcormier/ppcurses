require 'curses'

module PPCurses

  class PPWindow < Curses::Window

    def initialize(height, width, top, left)
      super(height,width,top,left)

      keypad(true)
      box('|', '-')
    end

  end



end
