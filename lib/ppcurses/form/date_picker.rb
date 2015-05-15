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
    attr_accessor :date

    def initialize(label, initial_date = Date.today)
      @label = label
      @display_width = 13
      @date = initial_date      
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
        
        if  @date_menu.nil?         
          @date_menu = PPCurses::DateMenu.new(@date)
        end

        @date_menu.set_origin(@combo_display_point)

        @date_menu.show
        @date_menu.menu_selection

        if @date_menu.pressed_enter
          @date = @date_menu.day
        end

      end

    end

    def clear
       @date = Date.today
    end

    #------------------------------------------------
    protected
    def display_string
      " #{@date.month}-#{@date.day}-#{@date.year} #{DOWN_ARROW}"
    end



  end

end