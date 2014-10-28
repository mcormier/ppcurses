module PPCurses

  class InputElement

    attr_accessor :label
    attr_accessor :size
    attr_accessor :selected


    def initialize(label, size )
      @label = label
      @size = size
      @selected = false
    end

    def show(screen)
      # Show Label
      screen.attron(A_REVERSE) if @selected
      screen.addstr("#{@label}: ")
      screen.attroff(A_REVERSE) if @selected

      # Show input value
      screen.attron(A_UNDERLINE)
      screen.addstr(''.ljust(@size))
      screen.attroff(A_UNDERLINE)
    end

  end

end