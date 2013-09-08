
require_relative 'BaseMenu.rb'

module PPCurses
  class RadioMenu  < BaseMenu

    def initialize( menu_items, action_items )
      @items = Array.new
      @actions = Array.new

      @menu_length = 0

       menu_items.each do |item|
         @items.push item
          @menu_length += item.length + 5
       end

      @selection = 0

      unless action_items.nil?

        action_items.each do |item|
          @actions.push item      
        end
      end 
     
      w_width = @menu_length + 4

      @win = Window.new(3, w_width ,0, (cols - w_width) / 2)

      @win.timeout=-1
      # Enables reading arrow keys in getch 
      @win.keypad(true)
    end

    def show
      @win.box('|', '-')
      y = 1
      x = 2

      @win.setpos(y, x)

      for i in 0...@items.length
        @win.addstr( @items[i] )
        if @selection == i then @win.addstr(' [*] ') else @win.addstr(' [ ] ') end
      end

     @win.refresh

    end


    def menu_selection

      while 1
        c = @win.getch

        self.handle_menu_selection(c)

        if c == 27 # ESCAPE
          @win.clear
          @win.refresh
          break
        end

      end 

    end


    def handle_menu_selection(c)
      n_choices = @items.length

      if c == KEY_RIGHT
        if @selection < n_choices - 1 then @selection += 1 else @selection = 0 end
        self.show()
      end

      if c == KEY_LEFT
        if @selection > 0 then @selection -= 1 else @selection = n_choices-1 end
        self.show()
      end

      if c == 10 then # ENTER
        unless @actions.nil?
          @actions[@selection].execute()
          self.show()
        end
      end
    end
   


    def close
      @win.close()
    end

  end

end
