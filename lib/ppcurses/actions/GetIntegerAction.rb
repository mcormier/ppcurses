require "curses"

class GetIntegerAction < PromptAction

  def execute()
   x = @parent.winPadding()
   y = @win.cury()
   begin 
     @win.setpos(y,x)
     @win.clrtoeol()
     @win.addstr(@prompt)
     @data = @win.getstr()
   end while not @data =~ /^\d+$/ 
  end

end

