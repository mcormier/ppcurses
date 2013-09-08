class BaseMenu

  def setSubMenu(menu)
    @subMenu = menu
  end

  def hide()
    @win.clear
    @win.refresh

    @subMenu.hide() if @subMenu      
  end

  def selected_menu_name()
    @items[@selection]
  end

end

