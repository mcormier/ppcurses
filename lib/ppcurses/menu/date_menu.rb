module PPCurses


  class DateMenu < ChoiceMenu

    def initialize(day)
     
      @meta_info = MetaMonth.new(day)

      @side_wall_char = '|'
      @top_bot_wall_char = '-'

      find_max_menu_width

      create_window
    end
  
    def day
      @meta_info.day
    end
  
  
    def find_max_menu_width
      @max_menu_width = 0
      
      str_array = @meta_info.month_str_array
      
      (0...str_array.length).each { |i|
        display = str_array[i]
        @max_menu_width = display.length if display.length > @max_menu_width
      }
    end
  
  
    def create_window
      w_height = @meta_info.month_str_array.length + 4
      w_width = @max_menu_width + 4
      @win = PPCurses::Window.new(w_height,w_width,(Curses.lines-w_height) / 2, (Curses.cols-w_width)/2)
      @win.timeout=-1
    end
  
  
    def show
      @win.box(self.side_wall_char, self.top_bot_wall_char)
      y = 2
      x = 2

      str_array = @meta_info.month_str_array

      str_array.each_with_index { |val, i| 
         @win.setpos(y, x)
         
         if i != @meta_info.day_row 
           @win.addstr(val)
         else
           num_of_digits = @meta_info.day.day > 9 ? 2 : 1
           @win.addstr(val[0, @meta_info.day_col])
           @win.attron(Curses::A_REVERSE)
           @win.addstr(val[@meta_info.day_col, num_of_digits])
           @win.attroff(Curses::A_REVERSE) 
           @win.addstr(val[@meta_info.day_col + num_of_digits, val.length])
         end
         
         y += 1
      }

       @win.refresh

       @sub_menu.show if @sub_menu
    end
    
  def handle_menu_selection(c)     

      curr_day = @meta_info.day

      if c == KEY_UP       
        curr_day = Date.jd(curr_day.jd - 7)
        @meta_info.day = curr_day
        self.show
        return true
      end

      if c == KEY_DOWN
        curr_day = Date.jd(curr_day.jd + 7)
        @meta_info.day = curr_day        
        self.show
        return true
      end

     if c == KEY_LEFT     
       curr_day = Date.jd(curr_day.jd - 1)
       @meta_info.day = curr_day        
       self.show
       return true
     end
      
     if c == KEY_RIGHT    
       curr_day = Date.jd(curr_day.jd + 1)
       @meta_info.day = curr_day        
       self.show
       return true
     end 
      #if c == ENTER && !@global_action.nil?
      # 
      #  unless @global_action.nil?
      #    @global_action.execute
      #  end
      #
      #  self.show
      #  return true
      #end

      #item_consumed = @menu_items[@selection].handle_key(c)
      #if item_consumed
      #  self.show
      #end

      #item_consumed
      false
    end


   
  
  end
  
end