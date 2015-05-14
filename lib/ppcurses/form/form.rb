module PPCurses

  class Form < View

    attr_accessor :selected_element

    #
    # Screen should be of type Curses::Window
    #
    def initialize
      super
      origin = Point.new( 1, 1 )
      setFrameOrigin(origin)
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
    # - def key_down(key)
    # - def selected=
    #
    def add (element)
      PPCurses.implements_protocol( element, %w(show height set_curs_pos key_down selected=))
      @elements.push(element)

      if  @selected_element.nil?
        set_selected_element(@elements[0])
      end
      
      @frame.size.height += element.height
      
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
       y = @frame.origin.y
       x = @frame.origin.x

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



    def set_selected_element(new_element)

      unless @selected_element.nil?
        @selected_element.selected=false
      end

      @selected_element = new_element
      @selected_element.selected=true

    end

  end

end