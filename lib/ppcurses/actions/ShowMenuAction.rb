require 'ppcurses/actions/BaseAction.rb'

module PPCurses
  class ShowMenuAction < BaseAction

    def initialize( menu )
      @menu = menu

    end

    def execute()
      @menu.show()
      @menu.getMenuSelection() 
    end

  end
end
