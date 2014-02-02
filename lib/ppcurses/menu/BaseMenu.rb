module PPCurses

  class BaseMenu

    attr_accessor :menu_items
    attr_accessor :selection

    attr_accessor :side_wall_char
    attr_accessor :top_bot_wall_char

    def initialize(menu_items, action_items)
      @menu_items=[]
      @selection=0
      @max_menu_width = 0

      @side_wall_char = '|'
      @top_bot_wall_char = '-'

      # Case 1: menu_items is a list of strings, with an associated action list
      build_menu_items(menu_items, action_items)

      # Case 2: Received a list of MenuItem

    end


    def build_menu_items(menu_items, action_items)
      @menu_items = []

      (0...menu_items.length).each { |i|
        menu_item = MenuItem.new
        menu_item.title = menu_items[i]
        unless action_items.nil?
          menu_item.action = action_items[i]
        end

        @menu_items.push(menu_item)
        @max_menu_width = menu_item.title.length if menu_item.title.length > @max_menu_width
      }
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
