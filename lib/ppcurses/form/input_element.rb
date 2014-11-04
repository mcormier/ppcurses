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




    def handle_keypress( key )

      if key == DELETE

        # Cursor is at the front of the string, nothing in
        # front of it to delete, or there is nothing to delete
        if @cursor_location == 0 or @value.length == 0
          return false
        end

        # Cursor is at the end of the string, remove the last character
        if @cursor_location == @value.length
          @value = @value.slice(0..@cursor_location-2)
        elsif @cursor_location == 1
          # cursor is right after the first character
          @value = @value.slice(1..@value.length-1)
        else
          # Cursor is in the middle of the string, remove the character at the cursor location
          # Example:
          #
          # abcdefg
          # 1234567
          #   ^ -> cursor-location = 3
          #
          @value = @value.slice(0..@cursor_location-2) + @value.slice(@cursor_location..@value.length-1)
        end

        @cursor_location -= 1
        return false
      end

      if key == KEY_LEFT
        @cursor_location -= 1 unless @cursor_location == 0
        return false
      end

      if key == KEY_RIGHT
        @cursor_location += 1 unless @cursor_location == @value.length
        return false
      end


      # Ignore control characters
      if key.is_a?(Fixnum)
        return false
      end

      # Adding new characters to the string

      # Check size of string before adding another character
      if @value.length >= @size
        # Ignore input
        return false
      end

      if @cursor_location == @value.length
        @value += key
      else
        @value = @value.slice(0..@cursor_location-1) + key + @value.slice(@cursor_location..@value.length-1)
      end

      @cursor_location += 1
      false
    end


    def set_curs_pos(screen)
      curs_set(VISIBLE)
      x =  @value_start_x_pos + @cursor_location

      screen.setpos( @value_start_y_pos, x )
    end

    def height
      1
    end

    # --------------------------------------------------------------------------------
    protected

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


  end

end