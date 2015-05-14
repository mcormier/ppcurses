module PPCurses

  class Button < View

    attr_accessor :label
    attr_accessor :selected
    attr_accessor :pushed

    attr_accessor :action

    def initialize(label)
      @label = label
      @selected = false
      @pushed = false
    end

    #
    # Screen should be of type Curses::Window
    #
    def show(screen)
      screen.attron(Curses::A_REVERSE) if @selected
      screen.addstr("< #{@label} >")
      screen.attroff(Curses::A_REVERSE) if @selected
    end

    def width
      @label.length + 4
    end

    def height
      1
    end

    def set_curs_pos(screen)
      Curses.curs_set(INVISIBLE)
    end

    def key_down( key )

      if key == ENTER
        @action.call unless action.nil?
      end

    end

  end




  # For grouping two buttons together, i.e. SUBMIT/CANCEL
  class ButtonPair < View

    attr_accessor :selected
    attr_accessor :selected_element

    attr_accessor :button1
    attr_accessor :button2

    def initialize(button1_label, button2_label)
      @button1 = Button.new(button1_label)
      @button2 = Button.new(button2_label)

      @selected_button = @button1

      @selected = false
    end

    def selected=(val)
      @selected_button.selected = val
      @selected=val
    end

    def height
      2
    end

    def set_curs_pos(screen)
      Curses.curs_set(INVISIBLE)
    end

    def key_down( key )
      if key == KEY_RIGHT or key == KEY_LEFT
        @selected_button.selected=false

        if @selected_button == @button1
          @selected_button = @button2
        else
          @selected_button = @button1
        end

        @selected_button.selected=true
        return
      end

      @selected_button.key_down(key)

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
