require_relative 'PromptAction.rb'

#noinspection RubyResolve
module PPCurses

  class GetIntegerAction < PromptAction

    def execute
     y = @win.cury
     @data = ''
     begin
       @win.setpos(y, x_padding)
       @win.clrtoeol
       @win.box('|', '-')
       @win.addstr(@prompt)
       Curses.echo
       @data = @win.getstr
       Curses.noecho
     end until @data =~ /^\d+$/
    end

  end

end
