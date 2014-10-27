module PPCurses

  class InputElement

    attr_accessor :label
    attr_accessor :size

    def initialize(label, size )
      @label = label
      @size = size
    end

    def show(screen)
      # Show Label
      screen.addstr("#{@label}: ")

      # Show input value
      screen.attron(A_UNDERLINE)
      screen.addstr(''.ljust(@size))
      screen.attroff(A_UNDERLINE)
    end

  end

end