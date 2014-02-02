# Curses reference:
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/curses/rdoc/Curses.html

require_relative 'BaseMenu.rb'
require 'curses'

module PPCurses
	#noinspection RubyResolve
  class Menu < BaseMenu

    # TODO -- use menu items, not strings and actions.
	  def initialize( menu_items, action_items )
      @items = []
      @actions = []
      @selection = 0

      @max_menu_width = 0

       menu_items.each do |item|
         @items.push item
         if item.length > @max_menu_width then @max_menu_width = item.length end
       end

      unless action_items.nil?
        action_items.each do |item|
          @actions.push item
        end
      end

      self.create_window

	  end

    def create_window
      w_height = @items.length + 4
      w_width = @max_menu_width + 4
      @win = Window.new(w_height,w_width,(lines-w_height) / 2, (cols-w_width)/2)

      @win.timeout=-1
      # Enables reading arrow keys in getch
      @win.keypad(true)
    end

	  def show
      @win.box('|', '-')
      y = 2
      x = 2

      for i in 0...@items.length
        @win.setpos(y, x)
        if @selection == i then @win.attron(A_REVERSE) end
        @win.addstr(@items[i])
        if @selection == i then @win.attroff(A_REVERSE) end
        y += 1
      end

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

        if not_processed then
          @sub_menu.handle_menu_selection(c) if @sub_menu
        end

      end

	  end
 
	  def handle_menu_selection(c)
		n_choices = @items.length

		if c == KEY_UP
		  if @selection == 0 then @selection = n_choices-1 else @selection -= 1 end
		  self.show
		  return true
		end

		if c == KEY_DOWN
		  if @selection == n_choices-1 then @selection = 0  else @selection += 1 end
		  self.show
		  return true
		end

		if c == 10 # ENTER

		  unless @global_action.nil?
			  @global_action.execute
		  end

		  unless @actions.nil? or @actions[@selection].nil?
			  @actions[@selection].execute
		  end

		  self.show
		  return true
		end

		 false
	  end


	  def close
      @win.close
 	 end

	end

end
