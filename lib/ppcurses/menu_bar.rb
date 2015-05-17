module PPCurses



  # The menubar is activated and deactivated by the ESCAPE key.
  #
  # Any responders further down the responder chain will never receive ESCAPE key events.
  #
  class MenuBar < Responder

    def initialize
      @menu_items = []
      @selected = false
    end

    # Expects screen to be a PPCurses::Screen object
    # Need to convert to work with a window or a view.
    def show(screen)

      screen.set_pos_by_point(ZERO_POINT)

      if @selected
       screen.attron(A_REVERSE)
      else
       screen.attron(A_UNDERLINE)
      end

      @menu_items.each do |menu_item|
        screen.addstr( "#{menu_item} ")
      end

      p = screen.cur_point

      screen.addstr( ' ' * (screen.width - p.x) )

      if @selected
        screen.attroff(A_REVERSE)
      else
        screen.attroff(A_UNDERLINE)
      end

    end


    def add_menu_item(menu_item)
      @menu_items.push(menu_item)
    end

    def remove_menu_item(menu_item)
      @menu_items.delete(menu_item)
    end

    def key_down( key )

      if key == ESCAPE
        @selected = !@selected
        return
      end

      if @selected
        @menu_items.each do |menu_item|
          if key == menu_item.key
            menu_item.action.call
            return
          end
        end
        return
      end

      @next_responder.key_down(key) unless @next_responder.nil?

    end

  end

  # Based on Cocoa NSMenuItem
  #
  # Current link, which probably won't be valid in the future ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSMenuItem_Class/index.html#//apple_ref/occ/instm/NSMenuItem/action
  # ----------------------------------------------------------
  # MenuBarItems ...
  #
  # q:Quit d:Del u:Undel
  #
  class MenuBarItem

    attr_accessor :key
    attr_accessor :label

    attr_accessor :action


    def initialize( key, label )
      @key = key
      @label = label
    end

    def to_s
      "#{@key}:#{@label}"
    end

  end

end
