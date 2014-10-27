module PPCurses

  class Form

    attr_accessor :elements

    def initialize (screen)
      @win = screen
      @elements = []
    end

    def show

      y = 1
      x = 1

      for i in @elements.each
        @win.setpos(y, x)
        i.show(@win)
      end

    end

  end

end