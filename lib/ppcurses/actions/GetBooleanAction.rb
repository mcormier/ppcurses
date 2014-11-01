require_relative 'PromptAction.rb'

#noinspection RubyResolve
module PPCurses

  class GetBooleanAction < PromptAction

    def initialize(prompt) 
      super(prompt)
      @state = false
    end

    def print_prompt
      super()
      @win.addstr('No [')
      if @state then @win.addstr(' ') else @win.addstr('X') end
      @win.addstr('] Yes [')
      if @state then @win.addstr('X') else @win.addstr(' ') end
      @win.addstr(']')
    end
   

    def execute
      print_prompt
      # Enables reading arrow keys in getch 
      @win.keypad(true)
      while 1
        noecho
        c = @win.getch

        if c == KEY_LEFT then @state = false end
        if c == KEY_RIGHT then @state = true end
        if c == ESCAPE then break end

        echo
        print_prompt
      end
      echo
    end

    def data
      if @state then return '1' end
      '0'
    end 

  end

end
