require_relative 'PromptAction.rb'

module PPCurses

  class GetIntegerAction < PromptAction

    def execute
     y = @win.cury()
     @data = ''
     begin 
       @win.setpos(y,xPadding())
       @win.clrtoeol()
       @win.box('|', '-')
       @win.addstr(@prompt)
       echo
       @data = @win.getstr()
       noecho
     end while not @data =~ /^\d+$/ 
    end

  end

end
