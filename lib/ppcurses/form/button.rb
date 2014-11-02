module PPCurses

  class Button

    attr_accessor :label
    attr_accessor :selected

    def initialize(label)
      @label = label
    end

    def show(screen)

      x = screen.curx
      y = screen.cury

      screen.addstr(''.ljust(@label.length + 4, '-'))
      y += 1
      screen.setpos(y,x)
      screen.attron(A_REVERSE) if @selected
      screen.addstr("| #{@label} |")
      screen.attroff(A_REVERSE) if @selected

      y += 1
      screen.setpos(y,x)
      screen.addstr(''.ljust(@label.length + 4, '-'))

    end


  end

end
