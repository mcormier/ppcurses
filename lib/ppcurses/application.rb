module PPCurses

  # noinspection RubyClassVariableUsageInspection
  class Application

    @@shared_app

    def initialize
      @screen = PPCurses::Screen.new

      @menubar = PPCurses::MenuBar.new
      quit_item = PPCurses::MenuBarItem.new('q', 'Quit')

      @menubar.add_menu_item(quit_item)

      @@shared_app = self
      @terminated = false
    end


    # TODO populate menu bar with menubar items.

    # Informal protocol
    # A delegate receives notifications if and only if a method is defined
    #
    # applicationDidFinishLaunching
    # applicationShouldTerminate
    #
    def set_delegate (delegate)
     @delegate = delegate
    end


    def launch
      @screen.setup_curses
      if @delegate.respond_to?(:applicationDidFinishLaunching)
          @delegate.applicationDidFinishLaunching(self)
      end

      @menubar.show(@screen)

      until @terminated
        c = @screen.get_ch

        # TODO -- create an NSResponder chain ...
        terminate
      end



      @screen.shutdown_curses

    end

    def terminate
      @terminated = true
    end

    def Application.sharedApplication
      @@shared_app
    end



  end

end
