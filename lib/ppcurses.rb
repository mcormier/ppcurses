gem 'curses', '=1.0.1'
require 'curses'
require 'date'

module PPCurses

  TAB   = 9
  ENTER = 10
  ESCAPE = 27
  DELETE = 127
  SPACE_BAR = ' '
  KEY_RIGHT = Curses::KEY_RIGHT
  KEY_LEFT = Curses::KEY_LEFT
  KEY_UP = Curses::KEY_UP
  KEY_DOWN = Curses::KEY_DOWN


  A_REVERSE = Curses::A_REVERSE
  A_UNDERLINE = Curses::A_UNDERLINE

  # To be used in conjunction with curs_set for more readable code e.g. Curses.curs_set(INVISIBLE)
  INVISIBLE = 0
  VISIBLE = 1

  def PPCurses.implements_protocol( element, methods )
    methods.each { |method|
      unless element.respond_to?(method); raise TypeError, "** Method #{method} MUST be defined **" end
    }
  end


 require_relative  'ppcurses/application.rb'
 require_relative  'ppcurses/notification_centre.rb'
 require_relative  'ppcurses/view.rb'
 require_relative  'ppcurses/menu_bar.rb'
 require_relative  'ppcurses/Screen.rb'
 require_relative  'ppcurses/geometry.rb'
 require_relative  'ppcurses/table_view.rb'

 # Dates ---------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/date/meta_month.rb'
 # Menus ---------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/menu/BaseMenu.rb'
 require_relative  'ppcurses/menu/Menu.rb'
 require_relative  'ppcurses/menu/CompositeMenu.rb'
 require_relative  'ppcurses/menu/RadioMenu.rb'
 require_relative  'ppcurses/menu/menu_item.rb'
 require_relative  'ppcurses/menu/choice_menu.rb'
 require_relative  'ppcurses/menu/date_menu.rb'
 # Actions -------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/actions/ShowMenuAction.rb'
 require_relative  'ppcurses/actions/GetStringAction.rb'
 require_relative  'ppcurses/actions/GetIntegerAction.rb'
 require_relative  'ppcurses/actions/NulAction.rb'

 # Forms ---------------------------------------------------------------------------------------------------------------
 require_relative  'ppcurses/form/form.rb'
 require_relative  'ppcurses/form/button.rb'
 require_relative  'ppcurses/form/input_element.rb'
 require_relative  'ppcurses/form/radio_button_group.rb'
 require_relative  'ppcurses/form/combo_box.rb'
 require_relative  'ppcurses/form/date_picker.rb'
  # Windows ------------------------------------------------------------------------------------------------------------
  require_relative  'ppcurses/window/pp_window.rb'


  ZERO_POINT = Point.new(0,0)

  NO = false
  YES = true
end


