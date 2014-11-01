module PPCurses

  class InputElement

    attr_accessor :label
    attr_accessor :value
    attr_accessor :size
    attr_accessor :selected

    attr_accessor :value_start_x_pos
    attr_accessor :value_start_y_pos

    # Stores the X location of the cursor relative to the
    # value being displayed.  If the cursor is in
    # the middle of the string then subsequent keys
    # will be added from this location, etc.
    attr_accessor :cursor_location


    def initialize(label, size )
      @label = label
      @size = size
      @selected = false
      @value = ''
      @cursor_location = 0
    end

    def show(screen)
      print_label( screen )

      @value_start_x_pos = screen.curx
      @value_start_y_pos = screen.cury

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
      # TODO -- handle the delete key
      # TODO -- handle editing in the middle of the string

      if key == KEY_LEFT then
        @cursor_location -= 1 unless @cursor_location == 0
        return
      end

      if key == KEY_RIGHT then
        @cursor_location += 1 unless @cursor_location == @value.length
        return
      end

      @value += key
      @cursor_location += 1
    end

    def set_curs_pos(screen)
      x =  @value_start_x_pos + @cursor_location

      screen.setpos( @value_start_y_pos, x )
    end

  end

end