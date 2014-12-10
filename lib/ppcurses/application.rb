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


  # Based on the Cocoa NSResponder
  #
  # Current link, which probably won't be valid in the future ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSResponder_Class/index.html#//apple_ref/occ/instp/NSResponder/menu
  #
  class Responder

    attr_accessor :next_responder

    #
    # Whether the responder accepts first responder status.
    #
    # As first responder, the receiver is the first object in the responder chain to be sent key events
    # and action messages. By default, this property is FALSE. Subclasses set this property to TRUE if the
    # receiver accepts first responder status.
    #
    def accepts_first_responder
      false
    end

    #
    # Notifies the receiver that it’s about to become first responder
    #
    # The default implementation returns TRUE, accepting first responder status. Subclasses can override
    # this method to update state or perform some action such as highlighting the selection, or to
    # return FALSE, refusing first responder status.
    #
    def become_first_responder
      true
    end

    #
    # Notifies the receiver that it’s been asked to relinquish its status as first responder in its window.
    #
    # The default implementation returns TRUE, resigning first responder status. Subclasses can override
    # this method to update state or perform some action such as unhighlighting the selection, or to
    # return FALSE, refusing to relinquish first responder status.
    #
    def resign_first_responder
      true
    end

    #
    # Informs the receiver that the user has pressed a key.
    #
    # The default implementation simply passes this message to the next responder.
    #
    def key_down( key )
      @next_responder.key_down(key) unless @next_responder.nil?
    end

  end

end
