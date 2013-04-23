require 'ppcurses/actions/BaseAction.rb'

module PPCurses

  class GetEnumeratedStringAction < PromptAction

    # enumeration is a list of possible values
    # i.e. CD, Vinyl, MP3
    def initialize(prompt, enumeration) 
      super(prompt)

      # verify enumeration is an array
      if ( enumeration.respond_to?('each_with_index') == false ) then
        raise
      end
      @options = enumeration
      @currOption = 0
    end

    def printPrompt()
      super()
      @options.each_with_index  do |option, index|
        @win.addstr(option)
        if ( index == @currOption ) then 
          @win.addstr(" [X] ")
        else
          @win.addstr(" [ ] ")
        end

      end
    end

    def execute()
      printPrompt()
      # Enables reading arrow keys in getch 
      @win.keypad(true)
      while(1)
        noecho
        c = @win.getch

        if c == KEY_LEFT then @currOption = @currOption-1 end
        if c == KEY_RIGHT then @currOption= @currOption+1 end
        if c == 10 then break end

        if (@currOption < 0 ) then @currOption = @options.length-1 end
        if (@currOption > @options.length-1 ) then @currOption = 0 end

        echo
        printPrompt()
      end
      echo
      # Go to next line so that further actions to overwrite
      # the choice
      @win.setpos(@win.cury() + 1, xPadding())
    end

    def data
      @options[@currOption]
    end 

  end

end
