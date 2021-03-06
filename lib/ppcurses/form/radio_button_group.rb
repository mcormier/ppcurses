# -*- encoding : utf-8 -*-

module PPCurses

  RADIO_NOT_SELECTED = '◎'
  RADIO_SELECTED = '◉'

  class RadioButtonGroup < View

    attr_accessor :selected
    attr_accessor :current_option

    #
    # label  : a label for the radio button group
    # options: an array of strings
    #
    def initialize( label, options )

      @label = label
      @options = options
      @current_option = 0
    end

    def show(screen)
      screen.attron(Curses::A_REVERSE) if @selected
      screen.addstr(" #{@label}:")
      screen.attroff(Curses::A_REVERSE) if @selected
      @options.each_with_index  do |option, index|
        if index == @current_option
          screen.addstr(" #{option} #{RADIO_SELECTED}  ")
        else
          screen.addstr(" #{option} #{RADIO_NOT_SELECTED}  ")
        end
      end
    end


    def key_down( key )
      if key == KEY_LEFT then @current_option = @current_option-1 end
      if key == KEY_RIGHT then @current_option = @current_option+1 end

      if @current_option < 0 then @current_option = @options.length-1 end
      if @current_option > @options.length-1 then @current_option = 0 end
    end

    def set_curs_pos(screen)
      Curses.curs_set(INVISIBLE)
    end

    def height
      1
    end
    
    def clear
     @current_option = 0
    end


  end

end
