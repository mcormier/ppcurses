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

      unless @selected_element.nil?
        @selected_element.selected=false
      end

      @selected_element = new_element
      @selected_element.selected=true

    end


    def handle_input
      n_choices = @elements.length

      set_selected_element(@elements[0])
      show

      while 1
        c = @win.getch

        #not_processed = !self.handle_menu_selection(c)

        if c == ESCAPE
          # exit for now
          break
        end

         if c == KEY_UP
           selected_index = @elements.index(@selected_element)
           (selected_index == 0) ? next_selection = n_choices - 1 : next_selection =  selected_index - 1
           set_selected_element(@elements[next_selection])
           show
         end

         if c == KEY_DOWN
           selected_index = @elements.index(@selected_element)
           (selected_index == n_choices-1) ? next_selection = 0 : next_selection = selected_index + 1
           set_selected_element(@elements[next_selection])
           show
         end

       # @sub_menu.handle_menu_selection(c) if not_processed && @sub_menu

      end

    end


  end

end