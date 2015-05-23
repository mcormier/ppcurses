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
  
    def day=(new_day)
      @meta_info.day = new_day
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
      
       @win.box(self.side_wall_char, self.top_bot_wall_char)
       @win.refresh

       @sub_menu.show if @sub_menu
    end
    
  def handle_menu_selection(c)     

      curr_day = @meta_info.day
      day_change = 0

     if c == KEY_UP    then day_change = -7 end       
     if c == KEY_DOWN  then day_change = 7  end   
     if c == KEY_LEFT  then day_change = -1 end      
     if c == KEY_RIGHT then day_change = 1  end 
     
     # Use vi key bindings for months and year
     # browsing.
     if c == 'l'       then day_change = 30   end 
     if c == 'h'       then day_change = -30  end
     if c == 'j'       then day_change = 365  end
     if c == 'k'       then day_change = -365 end
     
     if day_change != 0 
       curr_day = Date.jd(curr_day.jd + day_change)
       @meta_info.day = curr_day        
       self.show
       return true
     end
     
      false
    end


   
  
  end
  
end