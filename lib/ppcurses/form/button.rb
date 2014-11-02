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

    def width
      @label.length + 4
    end

  end

  # For grouping two buttons together, i.e. SUBMIT/CANCEL
  class ButtonPair



    def initialize(button1_label, button2_label)
      @button1 = Button.new(button1_label)
      @button2 = Button.new(button2_label)
    end

    def show(screen)

      # TODO -- create a Point class
      x = screen.curx
      y = screen.cury

      @button1.show(screen)

      x += @button1.width + 2
      screen.setpos(y,x)

      @button2.show(screen)

    end

    def handle_keypress( key )

    end


  end



end
