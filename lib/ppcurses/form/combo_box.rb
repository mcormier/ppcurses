# -*- encoding : utf-8 -*-

module PPCurses

  class ComboBox

    DOWN_ARROW = '∇'

    attr_accessor :selected

    def initialize(label, options)
      @label = label
      @options = options
    end

    def show(screen)
      screen.attron(A_REVERSE) if @selected
      screen.addstr("#{@label}:")

      @combo_display_point = screen.cur_point

      screen.attroff(A_REVERSE) if @selected
      screen.addstr(" - select - #{DOWN_ARROW}")
    end

    def height
      1
    end

    def set_curs_pos(screen)
      screen.curs_set(INVISIBLE)
    end

    def handle_keypress(key)

      if key == ENTER
        # TODO - Sub menu must handle ENTER
        options_menu = PPCurses::Menu.new( @options, nil )

        options_menu.set_origin(@combo_display_point)

        options_menu.show
        options_menu.menu_selection
        options_menu.close
      end

      false
    end

  end

end