
module PPCurses

  ENTER = 10
  ESCAPE = 27
  DELETE = 127
  SPACE_BAR = ' '

  
  INVISIBLE = 0
  VISIBLE = 1

 require_relative  'ppcurses/Screen.rb'
 # Menus
 require_relative  'ppcurses/menu/Menu.rb'
 require_relative  'ppcurses/menu/CompositeMenu.rb'
 require_relative  'ppcurses/menu/RadioMenu.rb'
 require_relative  'ppcurses/menu/menu_item.rb'
 # Actions
 require_relative  'ppcurses/actions/ShowMenuAction.rb'
 require_relative  'ppcurses/actions/GetStringAction.rb'
 require_relative  'ppcurses/actions/GetBooleanAction.rb'
 require_relative  'ppcurses/actions/GetIntegerAction.rb'
 require_relative  'ppcurses/actions/GetEnumeratedStringAction.rb'
 require_relative  'ppcurses/actions/GetDataAction.rb'
 require_relative  'ppcurses/actions/NulAction.rb'
 require_relative  'ppcurses/actions/InsertSQLDataAction.rb'
 # Forms
 require_relative  'ppcurses/form/form.rb'
 require_relative  'ppcurses/form/input_element.rb'

end


