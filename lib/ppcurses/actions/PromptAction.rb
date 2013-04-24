require_relative 'BaseAction.rb'

module PPCurses
  class PromptAction < BaseAction

    def initialize(prompt)
      @prompt = prompt
    end

    def setParentAction(action)
      @parent = action
    end

    def xPadding()
      if @parent.nil?
        return self.winPadding()
      else
        return @parent.winPadding()
      end
    end

    def printPrompt()
      @win.setpos(@win.cury(), xPadding())
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
