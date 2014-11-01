module PPCurses

  class InputElement

    attr_accessor :label
    attr_accessor :value
    attr_accessor :size
    attr_accessor :selected

    attr_accessor :cursor_x_pos
    attr_accessor :cursor_y_pos


    def initialize(label, size )
      @label = label
      @size = size
      @selected = false
      @value = ''
    end

    def show(screen)
      print_label( screen )

      # save cursor position based on value length
      @cursor_x_pos = screen.curx + @value.length
      @cursor_y_pos = screen.cury

      print_value( screen )
    end

    def print_label( screen )
      screen.attron(A_REVERSE) if @selected
      screen.addstr("#{@label}:")
      screen.attroff(A_REVERSE) if @selected
      screen.addstr(' ')
    end

    def print_value( screen )
      screen.attron(A_UNDERLINE)
      screen.addstr(@value.ljust(@size))
      screen.attroff(A_UNDERLINE)
    end

    def handle_menu_selection( key )

      # TODO -- filter control characters
      # TODO -- add a cursor position and move it based on the left and right arrow keys
      # TODO -- show the cursor...

      @value += key
    end

    def set_curs_pos(screen)
      screen.setpos( @cursor_y_pos, @cursor_x_pos )
    end

  end

end