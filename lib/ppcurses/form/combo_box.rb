# -*- encoding : utf-8 -*-

module PPCurses

  class ComboBox

    DOWN_ARROW = '∇'

    attr_accessor :selected

    def initialize( label, options)
      @label = label

    end

    def show(screen)
      screen.attron(A_REVERSE) if @selected
      screen.addstr("#{@label}:")
      screen.attroff(A_REVERSE) if @selected
      screen.addstr(" - select - #{DOWN_ARROW}")
    end

    def height
      1
    end

    def set_curs_pos(screen)
      curs_set(INVISIBLE)
    end

    def handle_keypress(key)

      if key == ENTER then
        # TODO -- open a menu with options...
      end

      false
    end

  end

end