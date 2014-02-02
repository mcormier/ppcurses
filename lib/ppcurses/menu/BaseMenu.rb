class BaseMenu

  attr_accessor :menu_items
  attr_accessor :selection

  attr_accessor :side_wall_char
  attr_accessor :top_bot_wall_char

  def initialize( menu_items, action_items )
    self.side_wall_char = '|'
    self.top_bot_wall_char = '-'
  end

  def set_sub_menu(menu)
    @sub_menu = menu
  end

  def hide
    @win.clear
    @win.refresh

    @sub_menu.hide if @sub_menu
  end

  def selected_menu_name
    @menu_items[@selection].title
  end

  def close
    @win.close
  end

end

