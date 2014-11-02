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

      screen.attron(A_REVERSE) if @selected
      screen.addstr(''.ljust(width, '-'))
      y += 1
      screen.setpos(y,x)

      screen.addstr("| #{@label} |")

      y += 1
      screen.setpos(y,x)
      screen.addstr(''.ljust(width, '-'))
      screen.attroff(A_REVERSE) if @selected

    end

    def width
      @label.length + 4
    end

  end

  # For grouping two buttons together, i.e. SUBMIT/CANCEL
  class ButtonPair

    attr_accessor :selected
    attr_accessor :selected_element

    def initialize(button1_label, button2_label)
      @button1 = Button.new(button1_label)
      @button2 = Button.new(button2_label)
    end

    def show(screen)

      # TODO -- create a Point class
      x = screen.curx
      y = screen.cury + 1
      screen.setpos(y,x)


      @button1.show(screen)

      x += @button1.width + 2
      screen.setpos(y,x)

      @button2.show(screen)

    end

    def handle_keypress( key )

      if key == KEY_LEFT or key == KEY_RIGHT
        if @selected_element == @button1
          set_selected_element(@button2)
        else
          set_selected_element(@button1)
        end
      end

    end


    def set_selected_element(new_element)

      unless @selected_element.nil?
        @selected_element.selected=false
      end

      @selected_element = new_element
      @selected_element.selected=true

    end

    def selected=(value)

      @selected=value

      if @selected_element.nil?
        set_selected_element(@button1)
      else
        @selected_element.selected=value
      end

    end

    def set_curs_pos(screen)
      curs_set(INVISIBLE)
    end

  end



end
