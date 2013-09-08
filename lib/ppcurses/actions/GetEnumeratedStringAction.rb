require_relative 'BaseAction.rb'

#noinspection RubyResolve
module PPCurses

  class GetEnumeratedStringAction < PromptAction

    # enumeration is a list of possible values
    # i.e. CD, Vinyl, MP3
    def initialize(prompt, enumeration) 
      super(prompt)

      # verify enumeration is an array
      unless enumeration.respond_to?('each_with_index') then
        raise
      end

      @options = enumeration
      @current_option = 0
    end

    def print_prompt
      super()
      @options.each_with_index  do |option, index|
        @win.addstr(option)
        if index == @current_option then
          @win.addstr(' [X] ')
        else
          @win.addstr(' [ ] ')
        end

      end
    end

    def execute
      print_prompt()
      # Enables reading arrow keys in getch 
      @win.keypad(true)
      while 1
        noecho
        c = @win.getch

        if c == KEY_LEFT then @current_option = @current_option-1 end
        if c == KEY_RIGHT then @current_option= @current_option+1 end
        if c == 10 then break end

        if @current_option < 0 then @current_option = @options.length-1 end
        if @current_option > @options.length-1 then @current_option = 0 end

        echo
        print_prompt()
      end
      echo
      # Go to next line so that further actions to overwrite
      # the choice
      @win.setpos(@win.cury() + 1, x_padding())
    end

    def data
      @options[@current_option]
    end 

  end

end
