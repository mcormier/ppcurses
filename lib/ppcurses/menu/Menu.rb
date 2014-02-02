# Curses reference:
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/curses/rdoc/Curses.html

require_relative 'BaseMenu.rb'
require 'curses'

module PPCurses
	#noinspection RubyResolve
  class Menu < BaseMenu

    # TODO -- use menu items, not strings and actions.

    # Case 1: menu_items is a list of strings, with an associated action list
    #
    # Case 2: Received a list of menu_items
	  def initialize( menu_items, action_items )
      super( menu_items, action_items )
      @selection = 0
      @max_menu_width = 0

      @menu_items = []

      self.build_menu_items( menu_items, action_items )

      self.create_window

	  end

    def build_menu_items( menu_items, action_items )
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

    def create_window
      w_height = @menu_items.length + 4
      w_width = @max_menu_width + 4
      @win = Window.new(w_height,w_width,(lines-w_height) / 2, (cols-w_width)/2)

      @win.timeout=-1
      # Enables reading arrow keys in getch
      @win.keypad(true)
    end

	  def show
      @win.box(self.side_wall_char, self.top_bot_wall_char)
      y = 2
      x = 2

      (0...@menu_items.length).each { |i|
        @win.setpos(y, x)
        @win.attron(A_REVERSE) if @selection == i
        @win.addstr(@menu_items[i].title)
        @win.attroff(A_REVERSE) if @selection == i
        y += 1
      }

       @win.refresh

       @sub_menu.show if @sub_menu
	  end

	  def set_global_action(action)
		  @global_action = action
	  end

	  def menu_selection

      while 1
        c = @win.getch

        not_processed = !self.handle_menu_selection(c)

        if c == 27  # ESCAPE
          self.hide
          break
        end

        @sub_menu.handle_menu_selection(c) if not_processed && @sub_menu

      end

	  end

    def handle_menu_selection(c)
      n_choices = @menu_items.length

      if c == KEY_UP
        (@selection == 0) ? @selection = n_choices - 1 : @selection -= 1
        self.show
        return true
      end

      if c == KEY_DOWN
        (@selection == n_choices-1) ? @selection = 0 : @selection += 1
        self.show
        return true
      end

      if c == 10 # ENTER

        unless @global_action.nil?
          @global_action.execute
        end

        unless @menu_items[@selection].action.nil?
          @menu_items[@selection].action.execute
        end

        self.show
        return true
      end

      false
    end


	end

end
