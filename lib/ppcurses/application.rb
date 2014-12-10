module PPCurses

  # noinspection RubyClassVariableUsageInspection
  class Application

    @@shared_app

    attr_accessor :main_menu

    def initialize
      @screen = PPCurses::Screen.new

      @main_menu = PPCurses::MenuBar.new
      quit_item = PPCurses::MenuBarItem.new('q', 'Quit')

      @main_menu.add_menu_item(quit_item)

      @@shared_app = self
      @terminated = false
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

      @main_menu.show(@screen)

      until @terminated
        c = @screen.get_ch

        # TODO -- create an NSResponder chain ...
        terminate
      end



      @screen.shutdown_curses

    end

    def terminate

      # Cocoa returns an NSApplicationTerminateReply which can
      # be a cancel, now or later response.  Simply support a boolean
      # for now.
      if @delegate.respond_to?(:applicationShouldTerminate)
        should_terminate = @delegate.applicationShouldTerminate(self)
        unless should_terminate
          return
        end
      end

      @terminated = true
    end

    def Application.sharedApplication
      @@shared_app
    end



  end

end


# Based on the Cocoa NSResponder
# https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSResponder_Class/index.html#//apple_ref/occ/instp/NSResponder/menu
#
# Responder -
#
# acceptsFirstResponder
# becomeFirstResponder
# resignFirstResponder
#
# nextResponder
#