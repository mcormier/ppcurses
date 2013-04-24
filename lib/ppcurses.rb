
module PPCurses
 require_relative  'ppcurses/Screen.rb'
 # Menus
 require_relative  'ppcurses/menu/Menu.rb'
 require_relative  'ppcurses/menu/CompositeMenu.rb'
 require_relative  'ppcurses/menu/RadioMenu.rb'
 # Actions
 require_relative  'ppcurses/actions/ShowMenuAction.rb'
 require_relative  'ppcurses/actions/GetStringAction.rb'
 require_relative  'ppcurses/actions/GetBooleanAction.rb'
 require_relative  'ppcurses/actions/GetIntegerAction.rb'
 require_relative  'ppcurses/actions/GetEnumeratedStringAction.rb'
 require_relative  'ppcurses/actions/GetDataAction.rb'
 require_relative  'ppcurses/actions/NulAction.rb'
 require_relative  'ppcurses/actions/InsertSQLDataAction.rb'
end


