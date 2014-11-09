module PPCurses

  class ComboBox

    attr_accessor :selected

    def initialize( label, options)

    end

    def show(screen)

    end

    def height
      1
    end

    def set_curs_pos(screen)
      curs_set(INVISIBLE)
    end

    def handle_keypress(key)
      false
    end

  end

end