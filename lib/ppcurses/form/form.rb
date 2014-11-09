module PPCurses

  class Form

    attr_accessor :selected_element

    def initialize (screen)
      @win = screen
      @elements = []

     set_button_pair( ButtonPair.new('Submit', 'Cancel') )
    end

    # Expects a ButtonPair object. Use to override the default Submit/Cancel labels
    def set_button_pair( pair )
      @button_pair = pair
    end

    # Adds an element to the form.  Elements are rendered in the order they are added.
    #
    # An element must implement the following protocol:
    #
    # - def show(screen)
    # - def height
    # - def set_curs_pos(screen)
    # - def handle_keypress(key)
    # - def selected=
    #
    def add (element)
      unless element.respond_to?('show'); raise TypeError, '** Method show should must be defined **' end
      unless element.respond_to?('height'); raise TypeError, '** Method height should must be defined **' end
      unless element.respond_to?('set_curs_pos'); raise TypeError, '** Method set_curs_pos should must be defined **' end
      unless element.respond_to?('handle_keypress'); raise TypeError, '** Method handle_keypress should must be defined **' end
      unless element.respond_to?('selected='); raise TypeError, '** Method selected= should must be defined **' end

      @elements.push(element)
    end


    # TODO - re-evaluate logic.  If branching too complicated.

    def handle_input

      @elements.push(@button_pair.button1)
      @elements.push(@button_pair.button2)

      n_choices = @elements.length

      set_selected_element(@elements[0])
      show

      while 1
        c = @win.getch

        if c == KEY_UP or c == KEY_DOWN or c == TAB

          selected_index = @elements.index(@selected_element)

          if c == KEY_DOWN or c == TAB
            (selected_index == n_choices-1) ? next_selection = 0 : next_selection = selected_index + 1
          else
            (selected_index == 0) ? next_selection = n_choices - 1 : next_selection =  selected_index - 1
          end

          set_selected_element(@elements[next_selection])
        elsif c == KEY_RIGHT and @selected_element == @button_pair.button1
            set_selected_element(@button_pair.button2)
        elsif c == KEY_LEFT and @selected_element == @button_pair.button2
            set_selected_element(@button_pair.button1)
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



    # --------------------------------------------------------------------------------
    protected

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

  end

end