gem 'curses', '=1.0.1'
require 'curses'

module PPCurses

  TAB   = 9
  ENTER = 10
  ESCAPE = 27
  DELETE = 127
  SPACE_BAR = ' '

  # To be used in conjunction with curs_set for more readable code e.g. Curses.curs_set(INVISIBLE)
  INVISIBLE = 0
  VISIBLE = 1

  def PPCurses.implements_protocol( element, methods )
    methods.each { |method|
      unless element.respond_to?(method); raise TypeError, "** Method #{method} MUST be defined **" end
    }
  end


 require_relative  'ppcurses/Screen.rb'
 require_relative  'ppcurses/pp_point.rb'
 # Menus ---------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/menu/Menu.rb'
 require_relative  'ppcurses/menu/CompositeMenu.rb'
 require_relative  'ppcurses/menu/RadioMenu.rb'
 require_relative  'ppcurses/menu/menu_item.rb'
 # Actions -------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/actions/ShowMenuAction.rb'
 require_relative  'ppcurses/actions/GetStringAction.rb'
 require_relative  'ppcurses/actions/GetBooleanAction.rb'
 require_relative  'ppcurses/actions/GetIntegerAction.rb'
 require_relative  'ppcurses/actions/GetEnumeratedStringAction.rb'
 require_relative  'ppcurses/actions/GetDataAction.rb'
 require_relative  'ppcurses/actions/NulAction.rb'
 require_relative  'ppcurses/actions/InsertSQLDataAction.rb'
 # Forms ---------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/form/form.rb'
 require_relative  'ppcurses/form/button.rb'
 require_relative  'ppcurses/form/input_element.rb'
 require_relative  'ppcurses/form/radio_button_group.rb'
 require_relative  'ppcurses/form/combo_box.rb'
  # Windows ------------------------------------------------------------------------------------------------------------
  require_relative  'ppcurses/window/pp_window.rb'

end


