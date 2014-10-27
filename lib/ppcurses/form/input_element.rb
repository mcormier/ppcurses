module PPCurses

  class InputElement

    attr_accessor :label
    attr_accessor :size

    def initialize(label, size )
      @label = label
      @size = size
    end

    def show(screen)
      screen.addstr("#{@label}: ")
    end

  end

end