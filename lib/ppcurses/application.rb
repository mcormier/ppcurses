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

    def Responder.isa( obj )
      PPCurses.implements_protocol( obj, %w(accepts_first_responder become_first_responder resign_first_responder key_down))
    end

  end


  #
  # Derived from methods defined in Cocoa NSWindow
  #
  # Current link, which probably won't be valid in the future ...
  #
  # https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWindow_Class/index.html#//apple_ref/occ/instm/NSWindow
  #
  class ResponderManager

    attr_accessor :first_responder

    #
    # Attempts to make a given responder the first responder
    #
    #
    # If responder isn’t already the first responder, this method first sends a resign_first_responder message
    # to the object that is the first responder. If that object refuses to resign, it remains the first responder,
    # and this method immediately returns FALSE. If the current first responder resigns, this method sends a
    # become_first_responder message to responder. If responder does not accept first responder status, the NSWindow object becomes first responder; in this case, the method returns YES even if responder refuses first responder status.
    #
    # If responder is nil, this method still sends resignFirstResponder to the current first responder. If the current first responder refuses to resign, it remains the first responder and this method immediately returns NO. If the current first responder returns YES from resignFirstResponder, the window is made its own first responder and this method returns YES.
    # The Application Kit framework uses this method to alter the first responder in response to mouse-down events; you can also use it to explicitly set the first responder from within your program. The responder object is typically an NSView object in the window’s view hierarchy. If this method is called explicitly, first send acceptsFirstResponder to responder, and do not call makeFirstResponder: if acceptsFirstResponder returns NO.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Use setInitialFirstResponder: to the set the first responder to be used when the window is brought onscreen for the first time.
    #
    def make_first_responder( responder )

      Responder.isa(responder)

      if responder != @first_responder
        will_resign = responder.resign_first_responder
        unless will_resign
          return false
        end
      end

      will_accept = responder.become_first_responder
      unless will_accept
        return false
      end

      @first_responder = responder

      true
    end


  end

end
