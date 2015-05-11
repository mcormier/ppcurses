# -*- encoding : utf-8 -*-

module PPCurses


  # Ruby date objects are immutable
  # ---------------------------------
  # 09-15-1950
  # 05-04-2015 = May 4th 2015
  class DatePicker < View

    DOWN_ARROW = '∇'

    # Does the element have focus in the form?
    attr_accessor :selected


    def initialize(label, initial_date = Date.today)
      @label = label
      @options = ['Maine', 'New York', 'Kansas', 'California']

      @display_width = 13
      @choice_made = false
  
      @date = initial_date


      @options.each do |option|
        if option.length > @display_width
          @display_width = option.length
        end
      end

    end

    def show(screen)
      screen.attron(A_REVERSE) if @selected
      screen.addstr("#{@label}:")

      @combo_display_point = screen.cur_point

      screen.attroff(A_REVERSE) if @selected

      screen.addstr(display_string)
    end

    def height
      1
    end

    def set_curs_pos(screen)
      screen.curs_set(INVISIBLE)
    end

    # Return Value
    # The object in the receiver's internal item list corresponding to the last item selected
    # from the pop-up list, or nil if no item is selected.
    def object_value_of_selected_item
      if  @options_menu.nil?
        return nil
      end

      @options[@options_menu.selection]
    end

    def key_down(key)

      if key == ENTER

        # TODO - display a calendar 
        
        if  @options_menu.nil?
          @options_menu = PPCurses::ChoiceMenu.new( @options )
        end

        @options_menu.set_origin(@combo_display_point)

        @options_menu.show
        @options_menu.menu_selection

        if @options_menu.pressed_enter
          @choice_made = true
        end

      end

    end

    #------------------------------------------------
    protected
    def display_string
      if @choice_made
        return ' '+ "#{@options[@options_menu.selection].center(@display_width,'-')} #{DOWN_ARROW}"
      end

      " #{@date.month}-#{@date.day}-#{@date.year} #{DOWN_ARROW}"
    end



  end

end