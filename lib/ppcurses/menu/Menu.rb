module PPCurses
  #noinspection RubyResolve
  class Menu < BaseMenu

    attr_accessor :selection

    def show
      @win.box(self.side_wall_char, self.top_bot_wall_char)
      y = 2
      x = 2

      (0...@menu_items.length).each { |i|
        @win.setpos(y, x)
        @win.attron(Curses::A_REVERSE) if @selection == i
        @win.addstr(@menu_items[i].display_string)
        @win.attroff(Curses::A_REVERSE) if @selection == i
        y += 1
      }

       @win.refresh

       @sub_menu.show if @sub_menu
    end

    def set_global_action(action)
      PPCurses.implements_protocol(action, %w(execute))
      @global_action = action
    end

    def menu_selection

      while 1
        c = @win.getch

        not_processed = !self.handle_menu_selection(c)

        if c == ESCAPE
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

      if c == ENTER && !@global_action.nil?

        unless @global_action.nil?
          @global_action.execute
        end

        self.show
        return true
      end

      item_consumed = @menu_items[@selection].handle_key(c)
      if item_consumed
        self.show
      end

      item_consumed
    end


  end

end
