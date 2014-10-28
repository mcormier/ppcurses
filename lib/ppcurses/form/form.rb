module PPCurses

  class Form

    attr_accessor :elements
    attr_accessor :selected_element

    def initialize (screen)
      @win = screen
      @elements = []
    end

    def show

      @selected_element = @elements[0]

      y = 1
      x = 1

      for i in @elements.each
        @win.setpos(y, x)
        i.show(@win)
        y = y + 1
      end

      # TODO display a button to exit SUBMIT/CANCEL

    end


    def handle_input

      while 1
        c = @win.getch

        #not_processed = !self.handle_menu_selection(c)

        if c == ESCAPE
          # exit for now
          break
        end

         if c == KEY_UP
           # TODO -- give focus to previous element
           break
         end

         if c == KEY_DOWN
           # TODO -- give focus to next element
           break
         end

       # @sub_menu.handle_menu_selection(c) if not_processed && @sub_menu

      end

    end


  end

end