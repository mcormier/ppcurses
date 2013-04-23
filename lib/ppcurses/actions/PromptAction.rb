require 'ppcurses/actions/BaseAction.rb'

module PPCurses
  class PromptAction < BaseAction

    def initialize(prompt)
      @prompt = prompt
    end

    def setParentAction(action)
      @parent = action
    end

    def printPrompt()
      if @parent.nil?
        @win.setpos(@win.cury() + 1, self.winPadding())
      else
        @win.setpos(@win.cury(), @parent.winPadding())
      end
      @win.addstr(@prompt)
    end

    def execute()
      printPrompt()
      echo
      @data = @win.getstr()
      noecho
    end

    def data
      @data
    end 

  end

end
