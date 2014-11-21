module PPCurses

  # noinspection RubyClassVariableUsageInspection
  class Application

    @@shared_app

    def initialize
      @screen = PPCurses::Screen.new
      @@shared_app = self
    end


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

      # TODO display default menu bar

      @screen.setup_curses

    end

    def Application.sharedApplication
      @@shared_app
    end



  end

end
