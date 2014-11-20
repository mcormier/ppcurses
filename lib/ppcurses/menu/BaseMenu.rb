module PPCurses

  #noinspection RubyResolve
  class BaseMenu

    attr_accessor :menu_items
    attr_accessor :selection

    attr_accessor :side_wall_char
    attr_accessor :top_bot_wall_char

    # TODO -- start using optional parameters....
    # Current base ruby is 1.9.2.  action_items could be an optional parameter
    # if the base was moved up to 2.0
    #
    def initialize(menu_items, action_items )
      @selection=0
      @max_menu_width = 0

      @side_wall_char = '|'
      @top_bot_wall_char = '-'

      sample = menu_items[0]

      case sample
        when String
          # Case 1: menu_items is a list of strings, with an associated action list
          build_menu_items(menu_items, action_items)
        else
          # Case 2: Received a list of MenuItem, or objects that implement
          # MenuItem protocol
          @menu_items=menu_items
      end

      find_max_menu_width

      create_window

    end

    def build_menu_items(menu_items, action_items)
      @menu_items = []

      (0...menu_items.length).each { |i|
        menu_item = MenuItem.new(menu_items[i])
        unless action_items.nil?
          menu_item.target= action_items[i].method(:execute)
        end

        @menu_items.push(menu_item)
      }
    end

    def find_max_menu_width
      @max_menu_width = 0
      (0...menu_items.length).each { |i|
        display = menu_items[i].display_string
        @max_menu_width = display.length if display.length > @max_menu_width
      }
    end

    def set_origin( point )
      @win.move_to_point( point )
    end

    def create_window
      w_height = @menu_items.length + 4
      w_width = @max_menu_width + 4
      @win = PPCurses::PPWindow.new(w_height,w_width,(Curses.lines-w_height) / 2, (Curses.cols-w_width)/2)
      @win.timeout=-1
    end

    def set_sub_menu(menu)
      @sub_menu = menu
    end

    def hide
      @win.clear
      @win.refresh

      @sub_menu.hide if @sub_menu
    end

    def selected_menu_name
      @menu_items[@selection].title
    end

    def close
      @win.close
    end

  end

end
