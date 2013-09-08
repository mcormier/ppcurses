require_relative 'BaseAction.rb'

#noinspection RubyResolve
module PPCurses

# An action that contains an array of prompt actions.  
# It can be used to group together multiple prompt actions.
#
class GetDataAction < BaseAction

  def initialize( actions )
    @actions = actions
    unless @actions.nil?
      @actions.each  do |action|
         action.set_parent_action(self)
      end
    end
  end

  def before_actions
    # Stub for classes that extend
  end

  def after_actions
    # Stub for classes that extend
  end


  def data
    values = []
    @actions.each  do |action|
       values.push(action.data())
    end
    values
  end

  def create_window
    super()
    # Assign window to actions
    unless @actions.nil?
      @actions.each  do |action|
         action.set_window(@win)
      end
    end
  end

  def execute
    create_window()
    echo

    @win.setpos(@win.cury,x_padding())

    self.before_actions()
    
    @actions.each  do |action|
      action.execute
    end

    self.after_actions()

    noecho
    @win.clear 
    @win.refresh
    @win.close
  end

  def print_line(string)
    @win.setpos(@win.cury(), win_padding())
    @win.addstr(string)
    @win.setpos(@win.cury() + 1, win_padding())
  end

  def print_success_line(string)
    init_pair(1, COLOR_GREEN, COLOR_BLACK)
    @win.attron(color_pair(1))
    self.print_line(string)
    @win.attroff(color_pair(1))
  end

  def print_error_line(string)
    init_pair(1, COLOR_RED, COLOR_BLACK)
    @win.attron(color_pair(1))
    self.print_line(string)
    @win.attroff(color_pair(1))
  end



end

end 

