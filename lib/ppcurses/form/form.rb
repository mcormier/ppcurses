module PPCurses

  class Form < View

    attr_accessor :selected_element

    #
    # Screen should be of type Curses::Window
    #
    def initialize
      @elements = []
    end

    # Formal protocol required
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
      PPCurses.implements_protocol( element, %w(show height set_curs_pos handle_keypress selected=))
      @elements.push(element)

      if  @selected_element.nil?
        set_selected_element(@elements[0])
      end

    end


    # TODO - re-evaluate logic.  If branching too complicated.

    # TODO -- remove boolean return from handle_keypress

    def handle_input

      unless @buttons_added
        @elements.push(@button_pair.button1)
        @elements.push(@button_pair.button2)
        @buttons_added = true
      end

      n_choices = @elements.length

      set_selected_element(@elements[0])
      show

      while 1
        # TODO -- rewrite to receive key events as a responder.
        # c = @win.getch

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
          # TODO this is just plain wrong.
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


    def key_down( key )

      if key == KEY_UP or key == KEY_DOWN or key == TAB
        selected_index = @elements.index(@selected_element)
        n_choices = @elements.length

        if key == KEY_DOWN or key == TAB
          (selected_index == n_choices-1) ? next_selection = 0 : next_selection = selected_index + 1
        else
          (selected_index == 0) ? next_selection = n_choices - 1 : next_selection =  selected_index - 1
        end

        set_selected_element(@elements[next_selection])
        return
      end

      @selected_element.key_down(key)

    end


    # TODO -- call display of subview???
    def display(screen)
      y = 1
      x = 1

      for i in 0..@elements.length - 1
        element = @elements[i]
        screen.setpos(y, x)
        element.show(screen)
        y += element.height
      end


      @selected_element.set_curs_pos(screen) unless @selected_element.nil?
    end

    # --------------------------------------------------------------------------------
    protected

    # Deprecated use display.
    def show
      y = 1
      x = 1

      for i in 0..@elements.length - 3
        element = @elements[i]
        @win.setpos(y, x)
        element.show(@win)
        y += element.height
      end

      @win.setpos(y, x)
      @button_pair.show(@win)

      @selected_element.set_curs_pos(@win)
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