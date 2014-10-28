module PPCurses

  class Form

    attr_accessor :elements
    attr_accessor :selected_element

    def initialize (screen)
      @win = screen
      @elements = []
    end

    def show

      y = 1
      x = 1

      for i in @elements.each
        @win.setpos(y, x)
        i.show(@win)
        y = y + 1
      end

      # TODO display a button to exit SUBMIT/CANCEL

    end


    def set_selected_element(new_element)
      if @selected_element.nil?
        @selected_element = new_element
      end

      @selected_element.selected=true

    end


    def handle_input

      set_selected_element(@elements[0])

      while 1
        c = @win.getch

        #not_processed = !self.handle_menu_selection(c)

        if c == ESCAPE
          # exit for now
          break
        end

         if c == KEY_UP
           #@selected_element = @selected_element - 1
           # TODO -- give focus to previous element
         end

         if c == KEY_DOWN
           #@selected_element = @selected_element + 1
           # TODO -- check bounds/use datastructure
         end

       # @sub_menu.handle_menu_selection(c) if not_processed && @sub_menu

      end

    end


  end

end