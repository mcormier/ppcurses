module PPCurses

  class Form


    attr_accessor :selected_element

    def initialize (screen)
      @win = screen
      @elements = []

      # TODO -- don't hard code labels.
      @button_pair = ButtonPair.new('Submit', 'Cancel')
    end

    def add (element)
      @elements.push(element)
    end

    def show
      y = 1
      x = 1

      for i in 0..@elements.length - 3
        element = @elements[i]
        @win.setpos(y, x)
        element.show(@win.stdscr)
        y += element.height
      end

      @win.setpos(y, x)
      @button_pair.show(@win.stdscr)

      @selected_element.set_curs_pos(@win.stdscr)
    end


    def set_selected_element(new_element)

      unless @selected_element.nil?
        @selected_element.selected=false
      end

      @selected_element = new_element
      @selected_element.selected=true

    end


    def handle_input

      @elements.push(@button_pair.button1)
      @elements.push(@button_pair.button2)

      n_choices = @elements.length

      set_selected_element(@elements[0])
      show

      while 1
        c = @win.getch

        if c == TAB
          tab_consumed = @selected_element.send_tab
        end

        if c == KEY_UP or c == KEY_DOWN or ( c == TAB and tab_consumed == false)

          selected_index = @elements.index(@selected_element)

          if c == KEY_DOWN or c == TAB
            (selected_index == n_choices-1) ? next_selection = 0 : next_selection = selected_index + 1
          else
            (selected_index == 0) ? next_selection = n_choices - 1 : next_selection =  selected_index - 1
          end

          set_selected_element(@elements[next_selection])
        else
          should_exit = @selected_element.handle_keypress(c)
          if should_exit
            break
          end
        end

      show

      end

    end

    def submitted?
      @button_pair.button1.pushed
    end


  end

end