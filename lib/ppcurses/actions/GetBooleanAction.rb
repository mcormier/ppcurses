require_relative 'PromptAction.rb'

module PPCurses

  class GetBooleanAction < PromptAction

    def initialize(prompt) 
      super(prompt)
      @state = false;
    end

    def printPrompt()
      super()
      @win.addstr("No [")
      if (@state == false) then @win.addstr("X") else @win.addstr(" ") end
      @win.addstr("] Yes [")
      if (@state == true) then @win.addstr("X") else @win.addstr(" ") end
      @win.addstr("]")
    end
   

    def execute()
      printPrompt()
      # Enables reading arrow keys in getch 
      @win.keypad(true)
      while(1)
        noecho
        c = @win.getch

        if c == KEY_LEFT then @state = false end
        if c == KEY_RIGHT then @state = true end
        if c == 10 then break end

        echo
        printPrompt()
      end
      echo
    end

    def data
      if @state == false then return "0" end
      "1"
    end 

  end

end
