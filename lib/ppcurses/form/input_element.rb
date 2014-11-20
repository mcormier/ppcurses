module PPCurses

  class InputElement

    attr_accessor :label
    attr_accessor :value
    attr_accessor :size
    attr_accessor :selected

    attr_accessor :filter

    attr_accessor :value_start_point


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
      @filter = nil
    end

    # Creates an InputElement that only allows integer input
    #
    def InputElement.new_integer_only( label, size)
      i_only = PPCurses::InputElement.new(label, size)
      i_only.filter =PPCurses::NumberFilter.new
      i_only
    end


    def show(screen)
      print_label( screen )

      @value_start_point = screen.cur_point

      print_value( screen )
    end


    def handle_keypress( key )

      if key == DELETE
        handle_delete
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

      unless passes_filter(key)
        return false
      end

      add_character(key)

      false
    end


    def passes_filter( key )
      if @filter.nil?
        return true
      end

      @filter.passes_filter( key )
    end


    def set_curs_pos(screen)
      Curses.curs_set(VISIBLE)
      x =  @value_start_point.x  + @cursor_location

      screen.setpos( @value_start_point.y, x )
    end


    def height
      1
    end

    # --------------------------------------------------------------------------------
    protected


    def print_label( screen )
      screen.attron(Curses::A_REVERSE) if @selected
      screen.addstr("#{@label}:")
      screen.attroff(Curses::A_REVERSE) if @selected
      screen.addstr(' ')
    end


    def print_value( screen )
      screen.attron(Curses::A_UNDERLINE)
      screen.addstr(@value.ljust(@size))
      screen.attroff(Curses::A_UNDERLINE)
    end


    def handle_delete
      # Cursor is at the front of the string, nothing in
      # front of it to delete, or there is nothing to delete
      if @cursor_location == 0 or @value.length == 0
        return
      end

      if @value.length == 1
        @value = ''
        @cursor_location = 0
        return
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
    end


    def add_character ( char )
      if @cursor_location == @value.length
        @value += char
      else
        @value = @value.slice(0..@cursor_location-1) + char + @value.slice(@cursor_location..@value.length-1)
      end

      @cursor_location += 1
    end

  end



  class NumberFilter

    def passes_filter( key )
      if key =~ /^\d+$/
        return true
      end

      false
    end

  end

end