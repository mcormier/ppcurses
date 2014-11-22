module PPCurses



  class MenuBar

    def initialize
      @menu_items = []
    end

    # Expects screen to be PPCurses::Screen object
    # Need to convert to work with a window or a view.
    def show(screen)

      screen.set_pos_by_point(ZERO_POINT)

      @menu_items.each do |menu_item|
        screen.print_with_attribute( "#{menu_item} ", A_REVERSE )
      end

      p = screen.cur_point

      screen.print_with_attribute( ' ' * (screen.width - p.x), A_REVERSE )
    end

    def add_menu_item(menu_item)
      @menu_items.push(menu_item)
    end

  end

  # MenuBarItems ...
  #
  # q:Quit d:Del u:Undel
  #
  class MenuBarItem

    attr_accessor :key
    attr_accessor :label


    def initialize( key, label )
      @key = key
      @label = label
    end


    def to_s
      "#{@key}:#{@label}"
    end

  end

end
