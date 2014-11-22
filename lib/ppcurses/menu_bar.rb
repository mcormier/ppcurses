module PPCurses



  class MenuBar

    # Expects screen to be PPCurses::Screen object
    def show(screen)
      screen.print_with_attribute( ' ' * screen.width, A_REVERSE )
    end

    def add_menu_item(menu_item)

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


  end

end
