class BaseMenu

  def set_sub_menu(menu)
    @sub_menu = menu
  end

  def hide
    @win.clear
    @win.refresh

    @sub_menu.hide if @sub_menu
  end

  def selected_menu_name
    @items[@selection]
  end

end

