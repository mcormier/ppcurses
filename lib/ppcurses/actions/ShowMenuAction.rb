require "curses"

class ShowMenuAction < BaseAction

  def initialize( menu )
    @menu = menu

  end

  def execute()
    @menu.show()
    @menu.getMenuSelection() 
  end

end

