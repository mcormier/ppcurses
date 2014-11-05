module PPCurses

  class Button

    attr_accessor :label
    attr_accessor :selected
    attr_accessor :pushed

    def initialize(label)
      @label = label
      @selected = false
      @pushed = false
    end

    #
    # Screen should be of type Curses::Window
    #
    def show(screen)

      x = screen.curx
      y = screen.cury

      screen.addstr(' ')
      screen.attron(A_REVERSE) if @selected
      screen.addstr(''.ljust(width-2, '-'))
      y += 1
      screen.setpos(y,x)

      screen.addstr("|")
      screen.attroff(A_REVERSE) if @selected
      screen.addstr(" #{@label} ")
      screen.attron(A_REVERSE) if @selected
      screen.addstr("|")

      y += 1
      screen.setpos(y,x)
      screen.attroff(A_REVERSE) if @selected
      screen.addstr(' ')
      screen.attron(A_REVERSE) if @selected
      screen.addstr(''.ljust(width-2, '-'))
      screen.attroff(A_REVERSE) if @selected

    end

    def width
      @label.length + 4
    end

    def height
      3
    end

    def set_curs_pos(screen)
      curs_set(INVISIBLE)
    end

    def handle_keypress( key )

      if key == ENTER
        @pushed=true
        return true
      end

      false
    end

  end




  # For grouping two buttons together, i.e. SUBMIT/CANCEL
  class ButtonPair

    attr_accessor :selected
    attr_accessor :selected_element

    attr_reader :button1
    attr_reader :button2

    def initialize(button1_label, button2_label)
      @button1 = Button.new(button1_label)
      @button2 = Button.new(button2_label)
      @selected = false
    end

    def show(screen)

      p = screen.cur_point
      p.y+=1
      screen.set_pos_by_point(p)


      @button1.show(screen)

      p.x += @button1.width + 2
      screen.set_pos_by_point(p)

      @button2.show(screen)

    end

  end



end
