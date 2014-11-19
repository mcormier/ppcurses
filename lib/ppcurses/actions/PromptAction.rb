require_relative 'BaseAction.rb'

#noinspection RubyResolve
module PPCurses
  class PromptAction < BaseAction

    def initialize(prompt)
      @prompt = prompt
    end

    def set_parent_action(action)
      @parent = action
    end

    def x_padding
      if @parent.nil?
        self.win_padding
      else
        @parent.win_padding
      end
    end

    def print_prompt
      @win.setpos(@win.cury, self.x_padding )
      @win.addstr(@prompt)
    end

    def execute
      print_prompt
      Curses.echo
      @data = @win.getstr
      Curses.noecho
    end

    def data
      @data
    end 

  end

end
