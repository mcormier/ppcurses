
module PPCurses

  class CompositeMenu

    def initialize(menu1, menu2)
      @menu1 = menu1
      @menu2 = menu2

      @menu1.set_sub_menu(menu2)

    end

    def show
      @menu1.show()
      @menu2.show()
    end


    def menu_selection
     @menu1.menu_selection()
    end
 
	  def close
      @menu1.close()
      @menu2.close()
 	  end

  end

end
