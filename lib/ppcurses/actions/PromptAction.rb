require "curses"


class PromptAction < BaseAction

  def initialize(prompt)
    @prompt = prompt
  end

  def setWindow(win)
    @win = win
  end

  def setParentAction(action)
    @parent = action
  end

  def printPrompt()
    @win.setpos(@win.cury(), @parent.winPadding())
    @win.addstr(@prompt)
  end

  def execute()
    printPrompt()
    @data = @win.getstr()
  end

  def data
    @data
  end 
end

