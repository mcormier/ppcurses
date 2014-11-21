module PPCurses

  class MenuBar

    # Expects screen to be PPCurses::Screen object
    def show(screen)
      screen.print_with_attribute( ' ' * screen.width, A_REVERSE )
    end


  end

end
