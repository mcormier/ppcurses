module PPCurses


  class ChoiceMenu < Menu

    attr_reader :selection
    attr_reader :pressed_enter

    def menu_selection
      while 1
        c = @win.getch

        if c == ESCAPE
          @pressed_enter = false
          self.hide
          break
        end

        if c == ENTER
          @pressed_enter = true
          self.hide
          break
        end

        self.handle_menu_selection(c)

      end
    end


  end

end
